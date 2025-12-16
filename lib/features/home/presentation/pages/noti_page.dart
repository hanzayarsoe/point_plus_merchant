import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/themes/extensions/app_colors.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/core/utils/helper_function.dart';
import 'package:merchant/features/history/presentation/pages/transaction_detail_page.dart';
import 'package:merchant/features/home/domain/entities/noti_entity.dart';
import 'package:merchant/features/home/presentation/bloc/noti_bloc/noti_bloc.dart';
import 'package:merchant/features/home/presentation/cubits/noti_count_cubit/noti_count_cubit.dart';
import 'package:merchant/features/home/presentation/widgets/custom_icon.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({super.key});

  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  Future<void> _handleNoti(
    BuildContext context, {
    required String notiId,
    required NotiDataEntity data,
    required bool read,
  }) async {
    if (!read) {
      context.read<NotiCountCubit>().markAsRead(notiId);
      context.read<NotiBloc>().add(NotiEvent.getNotifs());
    }
    if (data.transactionId != null) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return TransactionDetailPage(transactionId: data.transactionId!);
          },
        ),
      );
    } else if (data.requestId != null) {
      context.pushNamed(
        AppRoutes.requestTransactionDetail,
        pathParameters: {'id': data.requestId.toString()},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotiBloc(sl())..add(NotiEvent.getNotifs()),
      child: BlocBuilder<NotiBloc, PagingState<int, NotiEntity>>(
        builder: (context, state) {
          void fetchPage() {
            context.read<NotiBloc>().add(NotiEvent.getNotifs());
          }

          return Scaffold(
            appBar: CustomAppBar(
              title: 'Notification',
              automaticallyImplyLeading: true,
            ),
            body: PagedListView(
              state: state,
              fetchNextPage: fetchPage,
              builderDelegate: PagedChildBuilderDelegate<NotiEntity>(
                itemBuilder: (context, item, index) {
                  return item.when(
                    dateHeader: (dateHeader) {
                      return Padding(
                        padding: AppSpacing.defaultPadding,
                        child: Text(
                          HelperFunction.isNotiDateHeadIsToday(dateHeader)
                              ? 'New'
                              : dateHeader,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      );
                    },
                    notification:
                        (
                          id,
                          title,
                          message,
                          notificationType,
                          read,
                          createdAt,
                          data,
                        ) {
                          final isRedeem = data?.type?.toLowerCase().contains(
                            'redeem',
                          );
                          final isWithdraw = data?.type?.toLowerCase().contains(
                            'withdraw',
                          );
                          if (data == null) return SizedBox.shrink();
                          return InkWell(
                            onTap: () => _handleNoti(
                              context,
                              notiId: id.toString(),
                              data: data,
                              read: read,
                            ),
                            child: Container(
                              padding: AppSpacing.defaultPadding,
                              decoration: BoxDecoration(
                                color: !read
                                    ? Theme.of(context).colorScheme.secondary
                                    : null,
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).extension<AppColors>()!.dimGrayColor!,
                                  ),
                                ),
                              ),
                              child: Row(
                                spacing: AppSpacing.smallSpacing,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (isWithdraw != null && isRedeem != null)
                                    CustomIcon(
                                      icon: Icon(
                                        (isWithdraw || isRedeem)
                                            ? LucideIcons.arrowUpRight
                                            : LucideIcons.arrowDownRight,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.surface,
                                      ),
                                      padding: AppSpacing.smallPadding,
                                      paddingColor: Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer,
                                    ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: AppSpacing.smallSpacing,
                                    children: [
                                      Text(
                                        '$title',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                      Text(
                                        Formatter.formatUtcTimeToTimeago(
                                          createdAt,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: Theme.of(
                                                context,
                                              ).hintColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
