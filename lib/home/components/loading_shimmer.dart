import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingShimmer(BuildContext context) {
  double widthLayout = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.white,
            child: Container(
              margin: EdgeInsets.only(bottom: 10,),
              height: 56,
              width: widthLayout,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8)
              ),
            )
        ),
        Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.white,
            child: Container(
              margin: EdgeInsets.only(bottom: 10,),
              height: 20,
              width: widthLayout-100,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8)
              ),
            )
        ),
        Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.white,
            child: Container(
              // margin: EdgeInsets.only(top: 0,),
              height: 300,
              width: widthLayout,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8)
              ),
            )
        ),
        Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.white,
            child: Container(
              margin: EdgeInsets.only(top: 12,),
              height: 20,
              width: widthLayout-100,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8)
              ),
            )
        ),
        Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.white,
            child: Container(
              margin: EdgeInsets.only(top: 18, bottom: 10),
              height: 20,
              width: widthLayout,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8)
              ),
            )
        ),
        for(int i=0;i<2;i++) Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(top: 0,),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)
                    ),
                  )
              ),
              Expanded(child: Column(
                children: [
                  Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                      child: Container(
                        margin: EdgeInsets.only(left: 12),
                        height: 20,
                        width: widthLayout/1.4,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)
                        ),
                      )
                  ),
                  Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 12),
                        height: 20,
                        width: widthLayout/1.4,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)
                        ),
                      )
                  ),
                ],
              ))
            ],
          ),
        )
      ],
    ),
  );
}