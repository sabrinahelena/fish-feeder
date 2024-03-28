import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class telalogin extends StatefulWidget {
  const telalogin({Key? key}) : super(key: key);

  @override
  _telaloginState createState() => _telaloginState();
}

class menuprincipal extends StatefulWidget {
  const menuprincipal({Key? key}) : super(key: key);

  @override
  _menuprincipalState createState() => _menuprincipalState();
}

class _telaloginState extends State<telalogin> {
  // Definindo um estado para controlar a visibilidade da senha
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fish Feeder - Login",
          style: TextStyle(
            color: Color(0xFF045E83), // Cor do texto como #045E83
            fontFamily: 'Inter', // Usando a fonte Inter
            fontWeight: FontWeight.w600, // Peso da fonte 600
            fontSize: 25, // Tamanho da fonte 25
            letterSpacing: 2.0, // Espaçamento entre as letras
          ),
        ),
        backgroundColor: Color(0xFFB4D6E0), // Usando a cor personalizada para a AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/PeixeComendoHamburguer6.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Alinha os itens ao centro verticalmente
          crossAxisAlignment: CrossAxisAlignment.center, // Alinha os itens ao centro horizontalmente
          children: [
            SizedBox(height: 200), // Espaçamento superior de 200px
            // Campo de texto para o email
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF045E83), // Cor do texto
                ),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Color(0xFF045E83), // Cor do labelText
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true, // Preenchimento ativado
                  fillColor: Color(0xFFB4D6E0), // Cor de fundo 0xFFB4D6E0
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF045E83), // Cor da borda
                      width: 1.0, // Espessura da borda
                    ),
                    borderRadius: BorderRadius.circular(20), // Borda arredondada
                  ),
                ),
              ),
            ),
            // Campo de texto para a senha
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF045E83), // Cor do texto
                ),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    color: Color(0xFF045E83), // Cor do labelText
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true, // Preenchimento ativado
                  fillColor: Color(0xFFB4D6E0), // Cor de fundo 0xFFB4D6E0
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF045E83), // Cor da borda
                      width: 1.0, // Espessura da borda
                    ),
                    borderRadius: BorderRadius.circular(20), // Borda arredondada
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      // Invertendo o estado da visibilidade da senha
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    // Alterando o ícone com base no estado da visibilidade da senha
                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                obscureText: !_isPasswordVisible, // Oculta a senha se _isPasswordVisible for false
              ),
            ),
            // Botão de login
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  //Navegar para a tela menuprincipal
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => menuprincipal()),
                  );
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _menuprincipalState extends State<menuprincipal> {
  // Variável para armazenar o horário atual
  String horarioAtual = '10:00';

  // Variável para armazenar o horário da última alimentação
  String ultimaAlimentacao = '09:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Menu Principal",
          style: TextStyle(
            color: Color(0xFF045E83), // Cor do texto
            fontFamily: 'Inter', // Usando a fonte Inter
            fontWeight: FontWeight.w600, // Peso da fonte 600
            fontSize: 25, // Tamanho da fonte 25
            letterSpacing: 2.0, // Espaçamento entre as letras
          ),
        ),
        backgroundColor: Color(0xFFB4D6E0), // Usando a cor personalizada para a AppBar
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Fundoaquario.jpg"), // Fundo da imagem do aquário
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centraliza os elementos na vertical
              crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os elementos na horizontal
              children: [
                SizedBox(height: 100), // Espaçamento superior de 100px para o relógio
                // Relógio centralizado na tela
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time),
                    Text(
                      ' $horarioAtual',
                      style: TextStyle(
                        fontSize: 40, // Tamanho da fonte do relógio
                        fontWeight: FontWeight.bold, // Texto em negrito
                      ),
                    ), // Horário atual (substitua por sua lógica real de tempo)
                  ],
                ),
                SizedBox(height: 200), // Espaçamento entre o relógio e os botões
                // Coluna para os botões
                Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Centraliza os elementos na vertical
                  children: [
                    // Botão Programar Horário
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para programar o horário
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFFE1EC2B)), // Cor de fundo
                        foregroundColor: MaterialStateProperty.all(Color(0xFFFA803F)), // Cor do texto
                        side: MaterialStateProperty.all(BorderSide(
                          color: Color(0xFFE1EC2B), // Cor da borda
                          width: 1, // Largura da borda
                        )),
                      ),
                      child: Text('Programar Horário', style: TextStyle(fontSize: 15)),
                    ),
                    SizedBox(height: 10), // Espaçamento entre os botões
                    // Botão Alimentar Agora
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para alimentar agora
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFFE1EC2B)), // Cor de fundo
                        foregroundColor: MaterialStateProperty.all(Color(0xFFFA803F)), // Cor do texto
                        side: MaterialStateProperty.all(BorderSide(
                          color: Color(0xFFE1EC2B), // Cor da borda
                          width: 1, // Largura da borda
                        )),
                      ),
                      child: Text('Alimentar Agora', style: TextStyle(fontSize: 15)),
                    ),
                    SizedBox(height: 10), // Espaçamento entre os botões
                    // Botão Nível de Comida
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para definir o nível de comida
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFFE1EC2B)), // Cor de fundo
                        foregroundColor: MaterialStateProperty.all(Color(0xFFFA803F)), // Cor do texto
                        side: MaterialStateProperty.all(BorderSide(
                          color: Color(0xFFE1EC2B), // Cor da borda
                          width: 1, // Largura da borda
                        )),
                      ),
                      child: Text('Nível de Comida', style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
                SizedBox(height: 200), // Espaçamento inferior de 200px para a última alimentação
                // Texto "Última Alimentação"
                Text(
                  'Última Alimentação: $ultimaAlimentacao', // Mostra o horário da última alimentação
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20, // Tamanho da fonte para a última alimentação
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                // Lógica para o botão de dúvida
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFB4D6E0)), // Cor de fundo igual à do AppBar
                shape: MaterialStateProperty.all(CircleBorder()), // Formato de círculo
              ),
              child: Icon(Icons.help_outline, color: Colors.white, size: 40), // Ícone de dúvida
            ),
          ),
        ],
      ),
    );
  }
}