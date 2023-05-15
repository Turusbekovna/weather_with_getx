import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg_image_jpg.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _controller,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Издөө',
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 10, 201, 226)),
                        borderRadius: BorderRadius.circular(50)),
                    focusColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // TextButton(
            //     style: ButtonStyle(
            //         backgroundColor: MaterialStateProperty.all(
            //             Color.fromARGB(255, 125, 170, 215))),
            //     onPressed: () {},
            //     child: Text(
            //       'OK',
            //       style: TextStyle(fontSize: 30, color: Colors.white),
            //     ))
            TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 35, vertical: 15)),
                  backgroundColor: MaterialStateProperty.all(Colors.cyan),
                ),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    Navigator.pop(context, _controller.text);
                  }

                  FocusManager.instance.primaryFocus?.unfocus();
                  // log('${_controller.text}');
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
