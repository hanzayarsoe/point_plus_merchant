import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/features/history/presentation/bloc/transaction_detail_bloc/transaction_detail_bloc.dart';
import 'package:merchant/features/history/presentation/widgets/save_receipt.dart';
import 'package:merchant/features/history/presentation/widgets/transaction_detail_row.dart';
import 'package:merchant/features/history/presentation/widgets/transfer_info.dart';
import 'package:merchant/features/home/presentation/widgets/custom_icon.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';
import 'package:merchant/shared/widgets/show_success_toast.dart';
import 'package:permission_handler/permission_handler.dart';

class TransactionDetailPage extends StatefulWidget {
  final String transactionId;
  const TransactionDetailPage({super.key, required this.transactionId});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  final GlobalKey _globalKey = GlobalKey();

  Future<Uint8List?> _captureWidget() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      if (byteData == null) return null;
      Uint8List pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      return null;
    }
  }

  Future<void> _captureWidgetAndSave(
    BuildContext context,
    String transactionId,
  ) async {
    try {
      bool isGranted = false;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          isGranted = true;
        } else {
          final status = await Permission.storage.request();
          isGranted = status.isGranted;
        }
      } else if (Platform.isIOS) {
        final addOnlyStatus = await Permission.photosAddOnly.request();
        if (addOnlyStatus.isGranted) {
          isGranted = true;
        } else {
          final status = await Permission.photos.request();
          isGranted = status.isGranted || status.isLimited;
        }
      } else {
        isGranted = true;
      }

      if (isGranted) {
        final Uint8List? imageBytes = await _captureWidget();
        if (imageBytes == null) {
          showToast(
            message: "can't capture image!",
            type: ToastType.error,
          );
          return;
        }
        final String fileName =
            "$transactionId/${DateTime.now().millisecondsSinceEpoch}.png";

        final result = await ImageGallerySaverPlus.saveImage(
          imageBytes,
          name: fileName,
          quality: 90,
        );

        if (result['isSuccess'] == true) {
          if (!context.mounted) return;
          showSuccessToast(context, 'Receipt saved to Gallery');
        } else {
          showToast(
            message: "Failed to save Image!",
            type: ToastType.error,
          );
        }
      } else {
        showToast(
          message: 'Error: Storage or Photos Permission Denied',
          type: ToastType.error,
        );
        // Open settings only if relevant permission is permanently denied
        if (Platform.isAndroid) {
          final androidInfo = await DeviceInfoPlugin().androidInfo;
          if (androidInfo.version.sdkInt < 33 &&
              await Permission.storage.isPermanentlyDenied) {
            openAppSettings();
          }
        } else if (Platform.isIOS) {
          final addOnlyDenied =
              await Permission.photosAddOnly.isPermanentlyDenied;
          final photosDenied = await Permission.photos.isPermanentlyDenied;
          if (addOnlyDenied || photosDenied) {
            openAppSettings();
          }
        }
      }
    } catch (e) {
      showToast(message: e.toString(), type: ToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionDetailBloc(sl())
        ..add(
          TransactionDetailEvent.getTransactionDetail(
            id: int.parse(widget.transactionId),
          ),
        ),
      child: BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            orElse: () => false,
            loading: () => true,
          );
          final transaction = state.whenOrNull(
            loaded: (transaction) => transaction,
          );
          if (transaction == null) {
            return Center(child: CupertinoActivityIndicator());
          }
          final isWithdraw = transaction.type.toLowerCase().contains(
            'withdraw',
          );
          final isTransfer = transaction.type.toLowerCase().contains(
            'redemption',
          );
          final isReceived = transaction.type.toLowerCase().contains('earn');
          return LoadingOverlay(
            isLoading: isLoading,
            child: Scaffold(
              appBar: CustomAppBar(
                title: 'Transaction Detail',
                automaticallyImplyLeading: true,
              ),
              body: SingleChildScrollView(
                padding: AppSpacing.defaultPadding,
                child: Column(
                  children: [
                    RepaintBoundary(
                      key: _globalKey,
                      child: Container(
                        padding: AppSpacing.transactionDetailCardPadding,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: AppSpacing.smallCircularBorderRadius,
                        ),
                        child: Column(
                          children: [
                            CustomIcon(
                              icon: Icon(
                                isTransfer
                                    ? LucideIcons.arrowUpRight
                                    : isReceived
                                    ? LucideIcons.arrowDownRight
                                    : LucideIcons.sparkle,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              padding: AppSpacing.smallPadding,
                              paddingColor: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                            ),
                            AppSpacing.smallSizedBox,
                            Text(
                              isReceived
                                  ? 'Points Received'
                                  : isTransfer
                                  ? 'Points Transfer'
                                  : isWithdraw
                                  ? 'Withdraw'
                                  : 'Recharge',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            AppSpacing.largeSizedBox,
                            Divider(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            AppSpacing.smallSizedBox,
                            Row(
                              children: [
                                TransferInfo(
                                  type: 'From',
                                  accountNumber: transaction.fromAccount,
                                  name: transaction.fromAccountName ?? '',
                                ),
                                Padding(
                                  padding: AppSpacing.smallPadding,
                                  child: CustomIcon(
                                    icon: Icon(
                                      LucideIcons.arrowLeftRight,
                                      size: 20,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                    ),
                                    padding: AppSpacing.extraSmallPadding,
                                    paddingColor: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                  ),
                                ),
                                TransferInfo(
                                  type: 'To',
                                  accountNumber: transaction.toAccount,
                                  name: transaction.toAccountName ?? '',
                                ),
                              ],
                            ),
                            AppSpacing.smallSizedBox,
                            Divider(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            AppSpacing.smallSizedBox,
                            TransactionDetailRow(
                              title: 'Total Points',
                              text:
                                  '${isTransfer || isWithdraw ? '-' : '+'}${transaction.amount} pts',
                            ),
                            AppSpacing.largeSizedBox,
                            TransactionDetailRow(
                              title: 'Transaction ID',
                              text: transaction.id.toString(),
                            ),
                            AppSpacing.largeSizedBox,
                            TransactionDetailRow(
                              title: 'Transaction Type',
                              text: isTransfer
                                  ? 'Points Transfer'
                                  : isReceived
                                  ? 'Points Received'
                                  : isWithdraw
                                  ? 'Withdraw'
                                  : 'Recharge',
                            ),
                            AppSpacing.largeSizedBox,
                            TransactionDetailRow(
                              title: 'Date',
                              text:
                                  Formatter.formatUtcTimeToHistoryTransactionDate(
                                    transaction.createdAt,
                                  ),
                            ),
                            AppSpacing.largeSizedBox,
                            TransactionDetailRow(
                              title: 'Time',
                              text:
                                  Formatter.formatUtcTimeToHistoryTransactionTime(
                                    transaction.createdAt,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppSpacing.largeSizedBox,
                    SaveReceiptButton(
                      onPressed: () => _captureWidgetAndSave(
                        context,
                        transaction.id.toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
