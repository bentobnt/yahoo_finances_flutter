import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:yahoo_finances/controllers/chart_controller.dart';
import 'package:yahoo_finances/helpers/helper.dart';
import 'package:yahoo_finances/widgets/simple_chart.dart';

class ChartScreen extends GetView<ChartController> {
  ChartScreen({Key? key}) : super(key: key);

  final arguments = Get.arguments;
  var initialPrice = '';
  var finalPrice = '';

  @override
  Widget build(BuildContext context) {
    init();
    var variationText = controller.getActiveTitleAndVariation();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico'),
        backgroundColor: Color(0xFFB281248),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 30,
                ),
                child: Text(
                  'Variação do ativo nos últimos 30 dias',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                variationText,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:
                      variationText.contains('-') ? Colors.red : Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8,
                top: 20,
              ),
              child: SizedBox(
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: SimpleChart(
                  data: controller.activeData,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Preço inicial: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: initialPrice),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Preço final: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: finalPrice),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void init() {
    controller.activeData = arguments;
    initialPrice =
        Helper.getFormattedValue(controller.activeData.first.openValue);
    finalPrice = Helper.getFormattedValue(controller.activeData.last.openValue);
  }
}
