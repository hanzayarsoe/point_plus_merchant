import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_assets.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:merchant/features/home/data/models/point_transfer_model.dart';
import 'package:merchant/features/home/presentation/widgets/custom_icon.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final MobileScannerController _controller = MobileScannerController(
    autoStart: false,
  );
  String? _scannedValue;
  bool _isScanning = false;
  bool _isHandlingScan = false;
  static const Duration _scanCooldown = Duration(seconds: 1);

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImageAndScan() async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) return;
    setState(() {
      _isScanning = true;
    });
    final BarcodeCapture? capture = await _controller.analyzeImage(
      pickedImage.path,
    );

    if (capture != null && capture.barcodes.isNotEmpty) {
      _scannedValue = capture.barcodes.first.rawValue;
      if (_scannedValue != null && _scannedValue!.isNotEmpty) {
        setState(() {
          _isScanning = false;
        });
        _handleQrScan(_scannedValue!);
      }
    } else {
      setState(() {
        _isScanning = false;
      });
      showToast(
        message: "can't scan your image! please try again!",
        type: ToastType.info,
      );
    }
  }

  void _handleLiveScan(BarcodeCapture capture) {
    if (_isHandlingScan || capture.barcodes.isEmpty) return;
    final value = capture.barcodes.first.rawValue;
    if (value == null || value.isEmpty) return;
    _isHandlingScan = true;
    _scannedValue = value;
    log(_scannedValue.toString());
    _handleQrScan(_scannedValue!);
  }

  void _handleQrScan(String scannedValue) {
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(scannedValue);
      var data = PointTransferModel.fromJson(jsonMap);
      _controller.stop();
      context.pushNamed(AppRoutes.pointTransfer, extra: data.toEntity());
    } catch (e) {
      showToast(message: 'qr code is invalid', type: ToastType.error);
      if (!_controller.value.isRunning) {
        _controller.start();
      }
    } finally {
      Future.delayed(_scanCooldown, () {
        if (!mounted) return;
        _isHandlingScan = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isScanning,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(automaticallyImplyLeading: true),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.scannerPageBackgroundImage),
              colorFilter: ColorFilter.mode(
                Color.fromRGBO(37, 37, 37, 0.5),
                BlendMode.dstOut,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: AppSpacing.defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add QR Code',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  AppSpacing.extraLargeSizedBox,
                  AppSpacing.extraLargeSizedBox,
                  Text(
                    'Scan the QR code to transfer and receive points',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  AppSpacing.extraLargeSizedBox,
                  Flexible(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1.2,
                        child: ClipRRect(
                          borderRadius: AppSpacing.normalBorderRadiusCircular,
                          child: VisibilityDetector(
                            key: const Key('mobile-scanner'),
                            onVisibilityChanged: (info) {
                              final state = _controller.value;
                              if (info.visibleFraction == 0) {
                                if (state.isRunning) {
                                  _controller.stop();
                                }
                              } else {
                                if (!state.isRunning && !state.isStarting) {
                                  _controller.start();
                                }
                              }
                            },
                            child: MobileScanner(
                              controller: _controller,
                              onDetect: (result) => _handleLiveScan(result),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.extraLargeSizedBox,
                  Row(
                    spacing: AppSpacing.largeSpacing,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => _controller.toggleTorch(),
                        child: ValueListenableBuilder(
                          valueListenable: _controller,
                          builder: (context, state, child) {
                            final isEnabled = state.torchState == TorchState.on;
                            return CustomIcon(
                              icon: Icon(
                                isEnabled
                                    ? LucideIcons.zap
                                    : LucideIcons.zapOff,
                                size: 24,
                                color: Theme.of(
                                  context,
                                ).colorScheme.inverseSurface,
                              ),
                              padding: AppSpacing.normalPadding,
                              paddingColor: Colors.black,
                              linearGradientColor: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ],
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () => _pickImageAndScan(),
                        child: CustomIcon(
                          icon: Icon(
                            LucideIcons.image,
                            size: 24,
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                          padding: AppSpacing.normalPadding,
                          paddingColor: Colors.black,
                          linearGradientColor: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.onPrimaryContainer,
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.extraLargeSizedBox,
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: AppSpacing.smallPadding,
                        child: Text(
                          'or',
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: true,
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  AppSpacing.extraLargeSizedBox,
                  GradientElevatedButton(
                    onPressed: () =>
                        context.pushNamed(AppRoutes.searchAccount, extra: '0'),
                    text: 'Search With Phone Number',
                    isDisabled: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
