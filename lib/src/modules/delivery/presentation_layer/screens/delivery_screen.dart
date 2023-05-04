import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';
import '../bloc/order_bloc.dart';

class DeliveryScreen extends StatelessWidget {
  final List<String> productDetails;
  final double total;
  final String gift;

  const DeliveryScreen(
      {Key? key, required this.productDetails, required this.total,required this.gift})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = 1;
    var phoneController = TextEditingController();
    var addressController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        var bloc = OrderBloc.get(context);
        if (i == 1) {
          bloc.add(const GetDataUserEvent());
        }
        if (state is GetDataUserSuccessState) {
          phoneController.text = bloc.user!.phone;
          addressController.text = bloc.user!.address;
        }
        i = 0;
        final Completer<GoogleMapController> _controller =
            Completer<GoogleMapController>();

        List<Marker> myMarker = [
          Marker(
            markerId: MarkerId('${bloc.latitude}'),
            position: LatLng(bloc.latitude!, bloc.longitude!),
          ),
        ];
        //print(bloc.longitude);
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'تأكيد العنوان',
              ),
            ),
            body: state is! GetDataUserLoadingState
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20.0.sp),
                      child: Form(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20.sp,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 250.sp,
                                child: GoogleMap(
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                    bloc.add(
                                        ControlEvent(controller: _controller));
                                  },
                                  onTap: (latLong) {
                                    bloc.add(GoToLocationEvent(
                                        longitude: latLong.longitude,
                                        latitude: latLong.latitude));
                                  },
                                  markers: Set.from(myMarker),
                                  initialCameraPosition: CameraPosition(
                                    target:
                                        LatLng(bloc.latitude!, bloc.longitude!),
                                    zoom: 16,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              TextButton(
                                  onPressed: () {
                                    bloc.add(const GetMyLocationEvent());
                                  },
                                  child: Text(
                                    "موقعك الحالي ",
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w800),
                                  )),
                              SizedBox(
                                height: 10.sp,
                              ),
                              TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك اكتب رقم الهاتف ';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    prefixIcon: const Icon(Icons.phone),
                                    labelText: 'الهاتف'),
                              ),
                              SizedBox(
                                height: 20.sp,
                              ),
                              TextFormField(
                                controller: addressController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك اكتب العنوان';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    prefixIcon: const Icon(Icons.home),
                                    labelText: 'العنوان'),
                              ),
                              SizedBox(
                                height: 20.sp,
                              ),
                              Container(
                                alignment: AlignmentDirectional.center,
                                decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    borderRadius: BorderRadius.circular(20.sp)),
                                width: double.infinity,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.sp),
                                            topRight: Radius.circular(25.sp),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return BlocBuilder<OrderBloc,
                                              OrderState>(
                                            builder: (context, state) {
                                              return Padding(
                                                padding: EdgeInsets.all(20.sp),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'الدفع عن طريق ؟',
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.sp,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: ColorManager.primary,
                                                        borderRadius: BorderRadius.circular(
                                                          20.sp,
                                                        ),
                                                      ),

                                                      width: double.infinity,
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          bloc.add(AddOrderEvent(
                                                            howToPaid: false,
                                                            gift: gift,
                                                            address: addressController.text,
                                                            productDetails: productDetails,
                                                            total: total,
                                                            phone:phoneController.text,
                                                          ));
                                                        },
                                                        child: Text(
                                                          "الفيزا",
                                                          style: TextStyle(
                                                              color: ColorManager.white,
                                                              fontSize: 15.sp),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.sp,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: ColorManager.primary,
                                                          borderRadius: BorderRadius.circular(20.sp),),
                                                      width: double.infinity,
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          bloc.add(AddOrderEvent(
                                                              howToPaid: true,
                                                              gift: gift,
                                                              address: addressController.text,
                                                              productDetails: productDetails,
                                                              total: total,
                                                              phone: phoneController.text,
                                                          ));
                                                          Navigator.pop(context);
                                                          if (state is! AddOrderSuccessState) {
                                                            showDialog(context: context,
                                                              builder: (BuildContext context) =>
                                                                  AlertDialog(
                                                                    title: Text('تم إرسال الطلب ',style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 18.sp
                                                                    ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(context),
                                                                        child: const Text('اغلاق'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          bloc.add(NavigationToMainScreenEvent(context: context));
                                                                        },
                                                                        child: const Text('الرئسية'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                            );
                                                          }

                                                        },
                                                        child: Text(
                                                          "عند الاستلام",
                                                          style: TextStyle(
                                                              color:
                                                                  ColorManager
                                                                      .white,
                                                              fontSize: 15.sp),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }

                                  },
                                  minWidth: double.infinity,
                                  child: Text(
                                    'اطلب',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp),
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
      },
    );
  }
}
