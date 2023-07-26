import 'package:flutter/material.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/OpenLeadController/OpenLeadController.dart';

class OPLViewALL extends StatelessWidget {
   OPLViewALL({
    Key? key,
    required this.prdFUP
  }) : super(key: key);
  OpenLeadController prdFUP;
  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    return Container(
       width: Screens.width(context),
                  height: Screens.bodyheight(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.01,
                      vertical: Screens.bodyheight(context) * 0.01),
                      child: Column(
                        children: [
                           Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Wrap(
                            spacing: 10.0, 
                            runSpacing: 10.0, 
                            children:
                                listViewAll(theme, 
                               prdFUP
                                 )),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: Screens.width(context),
                  child: ElevatedButton(
                    onPressed: () {
                         prdFUP.viewAllSelected();
                    },
                    child: Text("Ok"),
                  ),
                )
                        ],
                      ),
    );
  }

    List<Widget> listViewAll(
    ThemeData theme,
    OpenLeadController openLeadController,
  ) {
      return List.generate(
        openLeadController.getviewData.length,
        (index) => GestureDetector(
          onTap: () {
            // openLeadController.isselectedBrand(index);
           openLeadController.isselectedViewAll(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getviewData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Text(openLeadController.getviewData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getviewData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } 
}