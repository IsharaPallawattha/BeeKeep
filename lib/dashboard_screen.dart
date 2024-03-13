import 'package:flutter/material.dart';
import 'live.dart';

class Dashboard extends StatelessWidget {
  List cateNames = [
    "Hive 1",
    "Hive 2",
    "Hive 3",
    "Hive 4",
    "Hive 5",
    "Hive 6",
  ];

  List<Color> cateColors = [
    const Color.fromARGB(255, 107, 104, 30),
    const Color.fromARGB(255, 107, 104, 30),
    const Color.fromARGB(255, 107, 104, 30),
    const Color.fromARGB(255, 107, 104, 30),
    const Color.fromARGB(255, 107, 104, 30),
    const Color.fromARGB(255, 107, 104, 30),
  ];

  List<Icon> cateIcons = [
    const Icon(Icons.inventory_2, color: Colors.white, size: 35),
    const Icon(Icons.inventory_2, color: Colors.white, size: 35),
    const Icon(Icons.inventory_2, color: Colors.white, size: 35),
    const Icon(Icons.inventory_2, color: Colors.white, size: 35),
    const Icon(Icons.inventory_2, color: Colors.white, size: 35),
    const Icon(Icons.inventory_2, color: Colors.white, size: 35),
  ];

  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 15, left: 15, right: 15, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.32,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 236, 24, 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),

                  //side nav
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.sort,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://cdn-icons-png.flaticon.com/512/1077/1077114.png"),
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello,",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Liyana GAY",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          //SizedBox(height: 20),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: " Search here...",
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            prefixIcon: const Icon(Icons.search, size: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.431,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 236, 24, 1),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.43,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  /*    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ), */
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: Column(
                          children: [
                            GridView.builder(
                              itemCount: cateNames.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.2,
                              ),
                              itemBuilder: (context, index) {
                                return ElevatedButton(
                                  onPressed: () {
                                    // navigate live.dart
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Live(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: cateColors[index],
                                      shape: BoxShape.circle,
                                    ),
                                    child: cateIcons[index],
                                  ),
                                  // child: const SizedBox(height: 10),
                                  // child: Text(
                                  //   cateNames[index],
                                  //   style: TextStyle(
                                  //     fontSize: 20,
                                  //     fontWeight: FontWeight.w500,
                                  //     color: Colors.black.withOpacity(0.6),
                                  //   ),
                                  // ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
