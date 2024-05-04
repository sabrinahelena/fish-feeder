import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class telalogin extends StatefulWidget {
  const telalogin({Key? key}) : super(key: key);

  @override
  _telaloginState createState() => _telaloginState();
}

class criaruser extends StatefulWidget {
  const criaruser({Key? key}) : super(key: key);

  @override
  _criaruserState createState() => _criaruserState();
}

class menuprincipal extends StatefulWidget {
  const menuprincipal({Key? key}) : super(key: key);

  @override
  _menuprincipalState createState() => _menuprincipalState();
}

class telainforma extends StatefulWidget{
  const telainforma({Key? key}) : super(key: key);

  @override
  _telainformaState createState() => _telainformaState();
}

class telanivelcomida extends StatefulWidget {
  const telanivelcomida({Key? key}) : super(key: key);

  @override
  _telaNivelComidaState createState() => _telaNivelComidaState();
}

class horariosalimentacao extends StatefulWidget {
  const horariosalimentacao({Key? key}) : super(key: key);

  @override
  _horariosalimentacao createState() => _horariosalimentacao();
}

class telaperfil extends StatefulWidget {
  const telaperfil({Key? key}) : super(key: key);

  @override
  _telaperfil createState() => _telaperfil();
}

class _telaloginState extends State<telalogin> {
  // Definindo um estado para controlar a visibilidade da senha
  bool _isPasswordVisible = false;
  bool _rememberMe = false; // Estado para controlar o estado do checkbox

  // Definindo uma string para armazenar a senha e o e-mail
  String _emailSalvo = "";
  String _senhaSalva = "";

  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _recuperarDados(); // Recuperando os dados salvos quando a tela é inicializada
  }

  _salvarDados() async {
    String emailDigitado = _emailController.text;
    String senhaDigitada = _senhaController.text;

    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString("email", emailDigitado); // Salvar o email se "Lembre de mim" estiver marcado
      await prefs.setString("senha", senhaDigitada); // Salvar a senha se "Lembre de mim" estiver marcado
    } else {
      await prefs.remove("email"); // Remover o email se "Lembre de mim" não estiver marcado
      await prefs.remove("senha"); // Remover a senha se "Lembre de mim" não estiver marcado
      _emailController.clear(); // Limpar o campo de email
      _senhaController.clear(); // Limpar o campo de senha
    }

    print("Email salvo: $emailDigitado");
    print("Senha salva: $senhaDigitada");
  }

  _recuperarDados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailSalvo = prefs.getString("email") ?? ""; // Recuperar o email salvo, se existir
      _senhaSalva = prefs.getString("senha") ?? ""; // Recuperar a senha salva, se existir
      _emailController.text = _emailSalvo; // Preencher o campo de email com o email salvo
      _senhaController.text = _senhaSalva; // Preencher o campo de senha com a senha salva
      _rememberMe = _emailSalvo.isNotEmpty && _senhaSalva.isNotEmpty; // Definir o estado do checkbox com base nos dados recuperados
    });
    print("Email recuperado: $_emailSalvo");
    print("Senha recuperada: $_senhaSalva");
  }

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
                controller: _emailController,
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
                controller: _senhaController,
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
            // Checkbox "Lembre de mim"
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value!;
                      _salvarDados(); // Salvando ou removendo os dados com base no estado do checkbox
                    });
                  },
                  activeColor: Color(0xFFEFAA4F), // Alterando a cor do checkbox selecionado
                ),
                Text(
                  'Lembre de mim',
                  style: TextStyle(
                    color: Colors.white, // Alterando a cor do texto para branco
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            // Botão de login
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  _salvarDados(); // Salvando os dados antes de ir para a próxima tela
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => menuprincipal()),
                  );
                },
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 10),
            // Texto "Sou novo, realizar cadastro" clicável
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => criaruser()),
                );
              },
              child: Text(
                'Sou novo, realizar cadastro',
                style: TextStyle(
                  color: Colors.lightBlueAccent, // Cor do texto
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  decoration: TextDecoration.underline, // Sublinhado
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _criaruserState extends State<criaruser> {
  @override
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fish Feeder - Cadastro",
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            // Campo de texto para o nome
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
                  labelText: 'Nome',
                  labelStyle: TextStyle(
                    color: Color(0xFF045E83), // Cor do labelText
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: Color(0xFFB4D6E0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF045E83),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
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
                  filled: true,
                  fillColor: Color(0xFFB4D6E0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF045E83),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
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
                  filled: true,
                  fillColor: Color(0xFFB4D6E0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF045E83),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                obscureText: !_isPasswordVisible,
              ),
            ),
            // Campo de texto para a confirmação de senha
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
                  labelText: 'Confirmar Senha',
                  labelStyle: TextStyle(
                    color: Color(0xFF045E83), // Cor do labelText
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: Color(0xFFB4D6E0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF045E83),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                obscureText: !_isConfirmPasswordVisible,
              ),
            ),
            // Botão de finalizar cadastro
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para finalizar o cadastro
                },
                child: Text('Finalizar Cadastro'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _telaperfil extends State<telaperfil> {
// Variáveis para armazenar os dados do usuário
  String nome = 'Nome do Usuário';
  String email = 'usuario@example.com';
  String senha = 'senha123';
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil do Usuário',
          style: TextStyle(
            color: Color(0xFF045E83),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 25,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Color(0xFFB4D6E0),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/FundoInfo.jpg"), // Caminho da imagem de fundo
            fit: BoxFit.cover, // Ajuste para cobrir toda a área do container
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Container(
            height: MediaQuery.of(context).size.height, // Altura igual à altura da tela
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    initialValue: nome,
                    onChanged: (value) {
                      setState(() {
                        nome = value;
                      });
                    },
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF045E83), // Cor do texto
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true, // Preenchimento ativado
                      fillColor: Color(0xFFB4D6E0), // Cor de fundo 0xFFB4D6E0
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'E-mail:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    initialValue: email,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF045E83), // Cor do texto
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true, // Preenchimento ativado
                      fillColor: Color(0xFFB4D6E0), // Cor de fundo 0xFFB4D6E0
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Senha:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    initialValue: senha,
                    onChanged: (value) {
                      setState(() {
                        senha = value;
                      });
                    },
                    obscureText: !_isPasswordVisible,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF045E83), // Cor do texto
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true, // Preenchimento ativado
                      fillColor: Color(0xFFB4D6E0), // Cor de fundo 0xFFB4D6E0
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para salvar os dados do usuário
                    // Você pode implementar a lógica de salvar os dados aqui
                    // Por exemplo, você pode chamar uma função para enviar os dados para um servidor
                    // Ou pode salvar localmente usando SharedPreferences, por exemplo
                  },
                  child: Text('Salvar'),
                ),
              ],
            ),
          ),
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
        actions: [
          // Ícone de perfil
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => telaperfil()),
              );
            },
          ),
        ],
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
            child: SingleChildScrollView( // Adicionando SingleChildScrollView para possibilitar a rolagem
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centraliza os elementos na vertical
                crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os elementos na horizontal
                children: [
                  SizedBox(height: 10), // Espaçamento superior de 100px para o relógio
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
                  SizedBox(height: 150), // Espaçamento entre o relógio e os botões
                  // Coluna para os botões
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Centraliza os elementos na vertical
                    children: [
                      // Botão Programar Horário
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => horariosalimentacao()),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => telanivelcomida()),
                          );
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
                  SizedBox(height: 260), // Espaçamento inferior de 200px para a última alimentação
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
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => telainforma()),
                );
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

class _telainformaState extends State<telainforma>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cuidados com o Peixe",
          style: TextStyle(
            color: Color(0xFF045E83), // Cor do texto como #045E83
            fontFamily: 'Inter', // Usando a fonte Inter
            fontWeight: FontWeight.w600, // Peso da fonte 600
            fontSize: 25, // Tamanho da fonte 25
            letterSpacing: 2.0, // Espaçamento entre as letras
          ),
        ),
        backgroundColor: Color(0xFFB4D6E0), // Usando a cor personalizada para a AppBar
        elevation: 0, // Removendo a sombra da barra de aplicativos
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/FundoInfo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Como Cuidar de um Peixe:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '1. Escolha um tanque adequado e mantenha a água limpa.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              Text(
                '- Escolha um aquário adequado para o tamanho e quantidade de peixes.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              Text(
                '- Posicione o aquário em um local estável, longe de correntes de ar e luz solar direta.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                '2. Alimentação:',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              Text(
                '- Alimente os peixes com uma dieta equilibrada e específica para a espécie.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              Text(
                '- Alimente o peixe regularmente, mas não em excesso.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                '3. Temperatura da água:',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              Text(
                '- Mantenha a temperatura da água dentro da faixa adequada para a espécie de peixe que você possui.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              Text(
                '- Use um termômetro para monitorar a temperatura regularmente.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                '4. Limpeza da água:',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              Text(
                '- Realize trocas parciais de água regularmente para remover resíduos e substâncias indesejadas.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              Text(
                '- Limpe o filtro do aquário conforme as instruções do fabricante para garantir seu bom funcionamento.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                '5. Observação:',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                '- Observe os peixes regularmente quanto a mudanças de comportamento, como falta de apetite, isolamento ou natação anormal.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              const Text(
                '- Procure sinais visíveis de doenças, como manchas, feridas, parasitas ou mudanças na coloração.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Dicas Adicionais:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '- Evite mudanças bruscas no ambiente do tanque.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              Text(
                '- Introduza novos peixes com cuidado para evitar conflitos territoriais.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              Text(
                '- Realize testes regulares de qualidade da água.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _telaNivelComidaState extends State<telanivelcomida> {
  @override
  Widget build(BuildContext context) {
    // Informações fictícias sobre o nível de comida
    int nivelComidaAtual = 70; // Nível de comida atual (em porcentagem)
    int capacidadeMaxima = 100; // Capacidade máxima do recipiente de comida

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nível de Comida",
          style: TextStyle(
            color: Color(0xFF045E83),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 25,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Color(0xFFB4D6E0),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/FundoInfo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Nível de Comida Atual:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Altera a cor do texto para branco
                    ),
                  ),
                  SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                      ),
                      CircularProgressIndicator(
                        value: nivelComidaAtual / capacidadeMaxima,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.blue, // Cor do indicador de progresso
                        ),
                        strokeWidth: 10,
                      ),
                      Text(
                        '$nivelComidaAtual%', // Exibe a porcentagem do nível de comida atual
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Capacidade Máxima: $capacidadeMaxima%', // Exibe a capacidade máxima do recipiente de comida
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Altera a cor do texto para branco
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _horariosalimentacao extends State<horariosalimentacao> {
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
            image: AssetImage('assets/water.jpeg'),
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
