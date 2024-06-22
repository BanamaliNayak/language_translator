import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslation extends StatefulWidget {
  const LanguageTranslation({super.key});

  @override
  State<LanguageTranslation> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslation> {

  var languages = ['Hindi', 'English'];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output ="";
  TextEditingController languageController = TextEditingController();
  void translate(String src,String dest,String input) async{
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input,from: src,to: dest);
    setState(() {
      output = translation.text.toString();
    });

    if(src=='--' || dest=='--'){
      setState(() {
        output = "Fail to translate";
      });
    }

  }

  String getLanguageCode(String language){
    if(language=="English"){
      return "en";
    }
    else if(language=="Hindi"){
      return "hi";
    }
    else{
      return "--";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10223d),
      appBar: AppBar(
        title: Text('Language Translator',
          style: TextStyle(color: Colors.cyanAccent,fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      focusColor: Colors.white,
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      hint: Text(
                        originLanguage,style: TextStyle(color: Colors.white),
                      ),
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: languages.map((String dropDownStringItem){
                        return DropdownMenuItem(child: Text(dropDownStringItem),value: dropDownStringItem,);
                      }).toList(),
                      onChanged: (String? value){
                        setState(() {
                          originLanguage = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Icon(Icons.arrow_right_alt_outlined,color: Colors.white,size: 40,),
                    SizedBox(width: 40),
                    DropdownButton(
                      focusColor: Colors.white,
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      hint: Text(
                        destinationLanguage,style: TextStyle(color: Colors.white),
                      ),
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: languages.map((String dropDownStringItem){
                        return DropdownMenuItem(child: Text(dropDownStringItem),value: dropDownStringItem,);
                      }).toList(),
                      onChanged: (String? value){
                        setState(() {
                          destinationLanguage = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Padding(padding: EdgeInsets.all(8),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    autofocus: false,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Please enter your text....',
                      labelStyle: TextStyle(fontSize: 15,color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1
                        )
                      ),
                      errorStyle: TextStyle(color: Colors.red,fontSize: 15),
                    ),
                    controller: languageController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter text to translate';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      translate(
                          getLanguageCode(originLanguage),
                          getLanguageCode(destinationLanguage),
                          languageController.text.toString());
                    }, child: Text('Translate',
                    style: TextStyle(color: Colors.cyanAccent),
                  ),),
                ),
                SizedBox(height: 20,),
                Text('\n$output',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
