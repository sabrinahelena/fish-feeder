import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class horariosalimentacao extends StatefulWidget {
  const horariosalimentacao({Key? key}) : super(key: key);

  @override
  _horariosalimentacao createState() => _horariosalimentacao();
}

class _horariosalimentacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Image Demo',
      home: BackgroundImageDemo(),
    );
  }
}

class BackgroundImageDemo extends StatefulWidget {
  @override
  _BackgroundImageDemoState createState() => _BackgroundImageDemoState();
}

class _BackgroundImageDemoState extends State<BackgroundImageDemo> {
  List<TextEditingController> timeControllers = [];
  List<TextEditingController> nameControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horarios de alimentação',
         style: TextStyle(
           fontSize:25,
           fontWeight:FontWeight.w600,
           color:Color(0xFF045E83),
           letterSpacing:2.0
        ),
      ),
        backgroundColor:Color(0xFFB4D6E0),

      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/water.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Insira os horários para o peixe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              for (var i = 0; i < timeControllers.length; i++)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        child: TextField(
                          controller: nameControllers[i],
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                            hintText: 'Nome',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Horário ${i + 1}: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: timeControllers[i],
                          keyboardType: TextInputType.datetime,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(8), // Limita o número máximo de caracteres
                            FilteringTextInputFormatter.digitsOnly, // Permite apenas dígitos
                            _HoraInputFormatter(), // Formata automaticamente para o formato HH:MM:SS
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                            hintText: 'HH:MM:SS',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (timeControllers.length < 6)
                ElevatedButton(
                  onPressed: () {
                    _adicionarHorario();
                  },
                  child: Text(
                    'Adicionar Horário',
                    style: TextStyle(color: Colors.blue), // Cor azul para o texto do botão
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _adicionarHorario() {
    setState(() {
      nameControllers.add(TextEditingController());
      timeControllers.add(TextEditingController());
    });
  }

  @override
  void dispose() {
    for (var controller in nameControllers) {
      controller.dispose();
    }
    for (var controller in timeControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class _HoraInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = _formatText(newValue.text);
    return newValue.copyWith(text: text, selection: TextSelection.collapsed(offset: text.length));
  }

  String _formatText(String text) {
    final RegExp regex = RegExp(r'^(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$');
    String formattedText = '';
    for (int i = 0; i < text.length; i++) {
      if (!regex.hasMatch(formattedText) && text[i] != ':') {
        formattedText += text[i];
        if (formattedText.length == 2 || formattedText.length == 5) {
          formattedText += ':';
        }
      }
    }
    return formattedText;
  }
}
