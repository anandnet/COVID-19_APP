import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool isHindi=false;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          height: screenSize.height,
          child: Image.asset(
            "assets/coronavirus1.jpg",
            fit: BoxFit.cover,
          )),
      SafeArea(
        child: Column(children: [
          Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Text(
                "COVID-19",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 44,
                    color: Colors.white),
              )),
          Container(
              width: screenSize.width * .95,
              height: screenSize.height * .83,
              child: Card(
                elevation: 20,
                color: Color.fromRGBO(57, 57, 59, 0.9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 15, right: 10, bottom: 20),
                    child: Column(children: <Widget>[
                      Container(
                        alignment: Alignment.topRight,
                        child:FlatButton(child: Text(isHindi?"English":"हिन्दी",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white),),onPressed: (){
                          setState(() {
                            isHindi=!isHindi;
                          });
                        },)
                      ),
                      _title(isHindi?"क्या है?":"About"),
                      _text(isHindi?aboutTextHindi:aboutText),
                      Divider(),
                      _title(isHindi?"लक्षण":"Symptoms"),
                      _text(isHindi?symptomsTextHindi:symptomsText),
                      Divider(),
                      _title(isHindi?"फैलाव":"Spread"),
                      _text(isHindi?spreadTextHindi:spreadText),
                      Divider(),
                      _title(isHindi?"रोकथाम":"Prevention"),
                      _text(isHindi?preventionTextHindi:preventionText),
                    ]),
                  ),
                ),
              )),
        ]),
      )
    ,SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 8,top:19),
        alignment: Alignment.topLeft,
        child: IconButton(icon: Icon(Icons.arrow_back,color:Colors.white,size:30), onPressed:(){
          Navigator.of(context).pop();
        }),
      ),
    )]));
  }

  Widget _text(String text) {
    return Text(text, style: TextStyle(fontSize: 18,color: Colors.white38
    ));
  }

  Widget _title(String titleText) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.topLeft,
        child: Text(
          titleText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
            ),
        ));
  }


String aboutText =
    """COVID-19 is the infectious disease caused by the most recently discovered coronavirus. This new virus and disease were unknown before the outbreak began in Wuhan, China, in December 2019.""";
String aboutTextHindi = "COVID-19 सबसे हाल ही में खोजे गए कोरोनावायरस के कारण होने वाला संक्रामक रोग है। यह नया वायरस और बीमारी दिसंबर 2019 में चीन के वुहान में फैलने से पहले अज्ञात थी।";
String symptomsText =
    "The most common symptoms of COVID-19 are fever, tiredness, and dry cough. Some patients may have aches and pains, nasal congestion, runny nose, sore throat or diarrhea. These symptoms are usually mild and begin gradually. Some people become infected but don’t develop any symptoms and don't feel unwell. Most people (about 80%) recover from the disease without needing special treatment. Around 1 out of every 6 people who gets COVID-19 becomes seriously ill and develops difficulty breathing. Older people, and those with underlying medical problems like high blood pressure, heart problems or diabetes, are more likely to develop serious illness. People with fever, cough and difficulty breathing should seek medical attention.";
String symptomsTextHindi = "COVID-19 के सबसे आम लक्षण बुखार, थकान और सूखी खांसी हैं। कुछ रोगियों में दर्द और दर्द, नाक की भीड़, नाक बह रही है, गले में खराश या दस्त हो सकता है। ये लक्षण आमतौर पर हल्के होते हैं और धीरे-धीरे शुरू होते हैं। कुछ लोग संक्रमित हो जाते हैं लेकिन कोई लक्षण विकसित नहीं करते हैं और अस्वस्थ महसूस नहीं करते हैं। अधिकांश लोगों (लगभग 80%) को विशेष उपचार की आवश्यकता के बिना बीमारी से उबरना पड़ता है। COVID-19 पाने वाले हर 6 में से 1 व्यक्ति गंभीर रूप से बीमार हो जाता है और सांस लेने में कठिनाई पैदा करता है। बूढ़े लोगों, और उच्च रक्तचाप, हृदय की समस्याओं या मधुमेह जैसी अंतर्निहित चिकित्सा समस्याओं वाले लोगों में गंभीर बीमारी विकसित होने की अधिक संभावना है। बुखार, खांसी और सांस लेने में कठिनाई वाले लोगों को चिकित्सा ध्यान देना चाहिए।";
String spreadText =
    "People can catch COVID-19 from others who have the virus. The disease can spread from person to person through small droplets from the nose or mouth which are spread when a person with COVID-19 coughs or exhales. These droplets land on objects and surfaces around the person. Other people then catch COVID-19 by touching these objects or surfaces, then touching their eyes, nose or mouth. People can also catch COVID-19 if they breathe in droplets from a person with COVID-19 who coughs out or exhales droplets. This is why it is important to stay more than 1 meter (3 feet) away from a person who is sick.";
String spreadTextHindi = "लोग वायरस वाले अन्य लोगों से COVID -19 पकड़ सकते हैं। यह बीमारी नाक या मुंह से छोटी बूंदों के माध्यम से एक व्यक्ति से दूसरे व्यक्ति में फैल सकती है जब सीओवीआईडी ​​-19 खांसी या साँस छोड़ता है। ये बूंदें व्यक्ति के आसपास की वस्तुओं और सतहों पर उतरती हैं। अन्य लोग तब इन वस्तुओं या सतहों को छूकर, फिर अपनी आँखों, नाक या मुंह को छूकर COVID -19 को पकड़ लेते हैं। लोग COVID -19 को भी पकड़ सकते हैं यदि वे COVID-19 वाले व्यक्ति से बूंदों में सांस लेते हैं जो खांसी करते हैं या बूंदों को बाहर निकालते हैं। यही कारण है कि बीमार रहने वाले व्यक्ति से 1 मीटर (3 फीट) से अधिक रहना महत्वपूर्ण है।";
String preventionText =
    """* Regularly and thoroughly clean your hands with an alcohol-based hand rub or wash them with soap and water.Why? Washing your hands with soap and water or using alcohol-based hand rub kills viruses that may be on your hands.
                                      \n* Maintain at least 1 metre (3 feet) distance between yourself and anyone who is coughing or sneezing.Why? When someone coughs or sneezes they spray small liquid droplets from their nose or mouth which may contain virus. If you are too close, you can breathe in the droplets, including the COVID-19 virus if the person coughing has the disease.
                                      \n* Avoid touching eyes, nose and mouth.Why? Hands touch many surfaces and can pick up viruses. Once contaminated, hands can transfer the virus to your eyes, nose or mouth. From there, the virus can enter your body and can make you sick.
                                      \n* Make sure you, and the people around you, follow good respiratory hygiene. This means covering your mouth and nose with your bent elbow or tissue when you cough or sneeze. Then dispose of the used tissue immediately.Why? Droplets spread virus. By following good respiratory hygiene you protect the people around you from viruses such as cold, flu and COVID-19.
                                      \n* Stay home if you feel unwell. If you have a fever, cough and difficulty breathing, seek medical attention and call in advance. Follow the directions of your local health authority.Why? National and local authorities will have the most up to date information on the situation in your area. Calling in advance will allow your health care provider to quickly direct you to the right health facility. This will also protect you and help prevent spread of viruses and other infections.
                                      \n* Keep up to date on the latest COVID-19 hotspots (cities or local areas where COVID-19 is spreading widely). If possible, avoid traveling to places  – especially if you are an older person or have diabetes, heart or lung disease.Why? You have a higher chance of catching COVID-19 in one of these areas.""";
String preventionTextHindi = """* नियमित रूप से और अच्छी तरह से अपने हाथों को अल्कोहल-आधारित हाथ से रगड़कर साफ करें या साबुन और पानी से धोएं। क्यों? अपने हाथों को साबुन और पानी से धोना या अल्कोहल-आधारित हाथ रगड़ना उन वायरस को मारता है जो आपके हाथों पर हो सकते हैं।
                                      \n * अपने आप को और खांसने या छींकने वाले किसी भी व्यक्ति के बीच कम से कम 1 मीटर (3 फीट) की दूरी बनाए रखें। जब किसी को खांसी या छींक आती है तो वे अपनी नाक या मुंह से छोटी तरल बूंदें छिड़कते हैं जिनमें वायरस हो सकता है। यदि आप बहुत करीब हैं, तो आप खांसी में सांस ले सकते हैं, जिसमें सीओवीआईडी ​​-19 वायरस भी शामिल है यदि खांसी करने वाले व्यक्ति को यह बीमारी है।
                                      \n * आँखें, नाक और मुँह छूने से बचें। क्यों? हाथ कई सतहों को छूते हैं और वायरस उठा सकते हैं। एक बार दूषित होने पर, हाथ वायरस को आपकी आंखों, नाक या मुंह में स्थानांतरित कर सकते हैं। वहां से, वायरस आपके शरीर में प्रवेश कर सकता है और आपको बीमार कर सकता है।
                                      \n * सुनिश्चित करें कि आप और आपके आस-पास के लोग, अच्छी श्वसन स्वच्छता का पालन करें। इसका मतलब है खांसी या छींक आने पर अपनी मुड़ी हुई कोहनी या टिशू से अपने मुंह और नाक को ढंकना। फिर उपयोग किए गए ऊतक का तुरंत निपटान करें। क्यों? बूंदों से वायरस फैलता है। अच्छी श्वसन स्वच्छता का पालन करके आप अपने आसपास के लोगों को सर्दी, फ्लू और सीओवीआईडी ​​-19 जैसे वायरस से बचाते हैं।
                                      \n *यदि आप अस्वस्थ महसूस करते हैं तो घर पर रहें। यदि आपको बुखार, खांसी और सांस लेने में कठिनाई है, तो चिकित्सा पर ध्यान दें और पहले से फोन करें। अपने स्थानीय स्वास्थ्य प्राधिकरण के निर्देशों का पालन करें। क्यों? आपके क्षेत्र की स्थिति की जानकारी के लिए राष्ट्रीय और स्थानीय अधिकारियों के पास सबसे अधिक तारीख होगी। अग्रिम में कॉल करने से आपका स्वास्थ्य देखभाल प्रदाता आपको जल्दी से सही स्वास्थ्य सुविधा के लिए निर्देशित कर सकेगा। यह आपकी रक्षा भी करेगा और वायरस और अन्य संक्रमणों को फैलने से रोकने में मदद करेगा।
                                      \n * नवीनतम COVID-19 हॉटस्पॉट (शहर या स्थानीय क्षेत्र जहां COVID-19 व्यापक रूप से फैल रहा है) पर अद्यतित रहें। यदि संभव हो, तो स्थानों की यात्रा करने से बचें - खासकर यदि आप एक बड़े व्यक्ति हैं या आपको मधुमेह, हृदय या फेफड़ों की बीमारी है। आपके पास इनमें से किसी एक क्षेत्र में COVID -19 को पकड़ने का एक उच्च मौका है।""";
}