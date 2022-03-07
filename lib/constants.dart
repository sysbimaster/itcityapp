import 'package:flutter/material.dart';
import 'package:itcity_online_store/resources/values.dart';

const kContainerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15), topRight: Radius.circular(15)));

const kAppBarContainerDecoration = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.LOGO_DARK_ORANGE, AppColors.LOGO_ORANGE]));
const kAppBarContainerDecorationtest = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white, Colors.white70]));

const kContainerFullDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15)),
);
const String productImage =
    'https://www.itcityonlinestore.com/uploads/product/single-product/';
const String categoryImage =
    'https://www.itcityonlinestore.com/uploads/category/app_image/';

const String homeImage =
    'https://www.itcityonlinestore.com/uploads/home-slider/';
const String homeAds =
    'https://www.itcityonlinestore.com/uploads/ads/';
