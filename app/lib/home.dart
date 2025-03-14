import 'package:app/dtls.dart';
import 'package:app/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var username = "No Name";
  var email = "No Email";
  Map<int, String> dtls = {
    0: "Elon musk",
    1: "steve jobs",
    2: "jack ma",
    3: "sam alman",
    4: "jack",
    5: "stephen hawking",
    6: "jhony depp",
    7: "Mesii",
    8: "Ronaldo",
    9: "ozil",
  };
  Map<int, String> dtlsImg = {
    0: "https://th.bing.com/th/id/OIP.zfh8IXXzxXsTBbu3kWLmjAHaIK?rs=1&pid=ImgDetMain",
    1: "https://th.bing.com/th/id/OIP.01IuiszHUAbaqCLccP9lRwAAAA?rs=1&pid=ImgDetMain",
    2: "https://th.bing.com/th/id/OIP.enXicXdtcEiFaIT6_HAfLwHaEK?rs=1&pid=ImgDetMain",
    3: "https://th.bing.com/th/id/OIP.oGDqE7BHy-VoF3t8T0zDBgHaE8?rs=1&pid=ImgDetMain",
    4: "https://buzzer.lk/wp-content/uploads/2022/10/Jackie-Chan-names-his-five-favourite-movies-of-all-time.jpg",
    5: "https://th.bing.com/th/id/OIP.3SdDzscOIdU86E9oAqfpjgHaHa?rs=1&pid=ImgDetMain",
    6: "https://media.a24.com/p/cfa5405a48272f9492846f9343e05c35/adjuntos/296/imagenes/009/504/0009504456/1200x675/smart/johnny-deppjpg.jpg",
    7: "https://www.aljazeera.com/wp-content/uploads/2022/12/2022-12-09T230002Z_911369896_UP1EIC91P9FZ3_RTRMADP_3_SOCCER-WORLDCUP-NLD-ARG-REPORT.jpg",
    8: "https://th.bing.com/th/id/R.bdaf134248601dc0743961e394092a7a?rik=5DQW%2fkWhe%2b%2f%2bhg&riu=http%3a%2f%2fsites.duke.edu%2fwcwp%2ffiles%2f2016%2f05%2fcristianoronaldo-1.jpg&ehk=5LKKipH6G9Zo9bWGcU%2b1jb7V1bSa556%2bj%2bAsJa2nNPA%3d&risl=&pid=ImgRaw&r=0",
    9: "https://th.bing.com/th/id/OIP.AJpmsWOO_XqJqcq4s7ROtgHaJq?rs=1&pid=ImgDetMain",
  };

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  Future<void> _getUserData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString("user_name") ?? "No Name";
      email = sharedPreferences.getString("email") ?? "No Email";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              await sharedPreferences.clear();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.blueAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Username: $username",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              "Email: $email",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.separated(
                  padding: EdgeInsets.all(8.0),
                  itemCount: 10,
                  itemBuilder:
                      (context, index) => ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => UserInfo(
                                    img: dtlsImg[index] ?? "not image",
                                    name: username,
                                    age: index.toString(),
                                  ),
                            ),
                          );
                        },
                        title: Text(
                          dtls[index] ?? "Unknown",
                          style: GoogleFonts.acme(color: Colors.black),
                        ),
                        subtitle: Text("Age 1${index}"),
                        leading:
                            index % 2 == 0
                                ? CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    dtlsImg[index] ?? "not",
                                  ),
                                )
                                : Container(
                                  width: 40,
                                  height: 40,
                                  child: Image.network(dtlsImg[index] ?? "not"),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                      ),
                  separatorBuilder: (context, index) => Divider(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
