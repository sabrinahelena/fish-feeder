import 'dart:async';
import 'dart:collection';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trabalho_lddm/firebase_options.dart';

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
  final String userId;

  menuprincipal({required this.userId});

  @override
  _menuprincipalState createState() => _menuprincipalState();
}

class telainforma extends StatefulWidget{
  const telainforma({Key? key}) : super(key: key);

  @override
  _telainformaState createState() => _telainformaState();
}

class telanivelcomida extends StatefulWidget {
  final String userId;

  telanivelcomida({required this.userId});

  @override
  _telaNivelComidaState createState() => _telaNivelComidaState();
}

class horariosalimentacao extends StatefulWidget {
  final String userId;

  horariosalimentacao({required this.userId});

  @override
  _horariosalimentacao createState() => _horariosalimentacao();
}

class telaperfil extends StatefulWidget {
  final String userId;

  telaperfil({required this.userId});

  @override
  _telaperfil createState() => _telaperfil(userId: userId);
}

class _telaloginState extends State<telalogin> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  String _emailSalvo = "";
  String _senhaSalva = "";

  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _recuperarDados();
  }

  Future<void> _verificarCredenciais(BuildContext context) async {
    final String email = _emailController.text;
    final String senha = _senhaController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      User? user = userCredential.user;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => menuprincipal(userId: user.uid)),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'Usuário não encontrado.';
      } else if (e.code == 'wrong-password') {
        message = 'Senha incorreta.';
      } else {
        message = 'Ocorreu um erro. Tente novamente.';
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _salvarDados() async {
    String emailDigitado = _emailController.text;
    String senhaDigitada = _senhaController.text;

    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString("email", emailDigitado);
      await prefs.setString("senha", senhaDigitada);
    } else {
      await prefs.remove("email");
      await prefs.remove("senha");
      _emailController.clear();
      _senhaController.clear();
    }

    print("Email salvo: $emailDigitado");
    print("Senha salva: $senhaDigitada");
  }

  Future<void> _recuperarDados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailSalvo = prefs.getString("email") ?? "";
      _senhaSalva = prefs.getString("senha") ?? "";
      _emailController.text = _emailSalvo;
      _senhaController.text = _senhaSalva;
      _rememberMe = _emailSalvo.isNotEmpty && _senhaSalva.isNotEmpty;
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
            image: AssetImage("assets/PeixeComendoHamburguer6.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                controller: _emailController,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF045E83),
                ),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Color(0xFF045E83),
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                controller: _senhaController,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF045E83),
                ),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    color: Color(0xFF045E83),
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
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value!;
                      _salvarDados();
                    });
                  },
                  activeColor: Color(0xFFEFAA4F),
                ),
                Text(
                  'Lembre de mim',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  _salvarDados();
                  _verificarCredenciais(context);
                },
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 10),
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
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
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
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<void> _adicionarUsuarioAoFirebase(BuildContext context) async {
    try {
      if (_senhaController.text == _confirmarSenhaController.text) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailController.text, password: _senhaController.text);

        // Obtém o UID do usuário recém-criado
        String uid = userCredential.user!.uid;

        // Adiciona dados do usuário na coleção 'Usuarios' do Firestore
        await FirebaseFirestore.instance.collection('Usuarios').doc(uid).set({
          'uid': uid,
          'nome': _nomeController.text,
          'email': _emailController.text,
          'senha': _senhaController.text,
          // Você pode adicionar mais campos conforme necessário
        });

        // Exibe mensagem de sucesso
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sucesso'),
              content: Text('Cadastro realizado com sucesso.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => telalogin()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Senha e confirmação de senha não coincidem, exibir mensagem de erro
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text(
                  'As senhas não coincidem. Por favor, tente novamente.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

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
            SizedBox(height: 20),
            // Campo de texto para o nome
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                controller: _nomeController,
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
                    icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                obscureText: !_isPasswordVisible,
              ),
            ),
            // Campo de texto para a confirmação de senha
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                controller: _confirmarSenhaController,
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
                    icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                obscureText: !_isConfirmPasswordVisible,
              ),
            ),
            SizedBox(height: 20),
            // Botão de cadastro
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  _adicionarUsuarioAoFirebase(context);
                },
                child: Text('Cadastrar'),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _telaperfil extends State<telaperfil> {
  late String nome = '';
  late String email = '';
  late String senha = '';
  bool _isPasswordVisible = false;
  final String userId; // Adicionando userId como um campo
  bool _isLoading = true; // Variável para controlar o carregamento

  // Modificando o construtor para aceitar userId como parâmetro
  _telaperfil({required this.userId});

  @override
  void initState() {
    super.initState();
    _recuperarInformacoesUsuario(); // Chama a função para recuperar as informações do usuário
  }

  Future<void> _recuperarInformacoesUsuario() async {
    // Lógica para recuperar as informações do usuário com base no userId do Firebase Firestore
    try {
      print('Recuperando informações do usuário com ID: $userId');
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Usuarios').doc(userId).get();

      if (userDoc.exists) {
        print('Informações do usuário encontradas: ${userDoc.data()}');
        setState(() {
          nome = userDoc['nome'] ?? '';
          email = userDoc['email'] ?? '';
          senha = userDoc['senha'] ?? '';
          _isLoading = false;
        });
      } else {
        print('Documento do usuário não encontrado.');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Erro ao recuperar informações do usuário: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Função para salvar os dados do usuário
  Future<void> _salvarDados(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('Usuarios').doc(userId).update({
        'nome': nome,
        'email': email,
        'senha': senha,
      });

      // Atualizando a senha do usuário autenticado no Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(senha);
      }

      // Exemplo de como você pode exibir um diálogo informando que os dados foram salvos
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sucesso'),
            content: Text('Informações atualizadas com sucesso.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Erro ao salvar dados do usuário: $e');
    }
  }

  // Função para excluir a conta do usuário
  Future<void> _excluirConta(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('Usuarios').doc(userId).delete();

      // Também exclui o usuário do Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
      }

      // Após excluir a conta, redireciona o usuário para a tela de login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => telalogin()),
      );
    } catch (e) {
      print('Erro ao excluir conta do usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Verifica se as informações do usuário foram carregadas
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Perfil do Usuário'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
            image: AssetImage("assets/FundoInfo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                      color: Color(0xFF045E83),
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xFFB4D6E0),
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
                      color: Color(0xFF045E83),
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xFFB4D6E0),
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
                      color: Color(0xFF045E83),
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xFFB4D6E0),
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
                    _salvarDados(context);
                  },
                  child: Text('Salvar'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _excluirConta(context);
                  },
                  child: Text('Excluir Conta'),
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
  late Database _database;

  // Variável para armazenar o horário atual
  String horarioAtual = '';

  // Variável para armazenar o horário da última alimentação
  String ultimaAlimentacao = '09:00';

  @override
  void initState() {
    super.initState();
    _abrirBancoDeDados(); // Abre o banco de dados
    _carregarUltimaAlimentacao(); // Carrega a última alimentação ao iniciar
    _atualizarHorarioAtual(); // Chama a função para atualizar o horário atual
    // Configura um Timer para atualizar o horário a cada segundo
    Timer.periodic(Duration(seconds: 1), (timer) {
      _atualizarHorarioAtual();
    });
  }

  // Função para abrir o banco de dados
  void _abrirBancoDeDados() async {
    final String dbpath = path.join(await getDatabasesPath(), 'nome_do_seu_banco_de_dados.db');
    _database = await openDatabase(
      dbpath,
      onCreate: (db, version) {
        // Cria a tabela Alimentação se ainda não existir
        return db.execute(
          "CREATE TABLE Alimentacao(id INTEGER PRIMARY KEY, id_pessoa INTEGER, nivel_comida INTEGER, ultima_alimentacao TEXT)",
        );
      },
      version: 1,
    );
  }

  // Função para atualizar o horário atual
  void _atualizarHorarioAtual() {
    setState(() {
      // Obtém o horário atual do sistema
      DateTime now = DateTime.now();
      // Formata o horário para uma string no formato HH:mm
      horarioAtual = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    });
  }

  // Função para carregar a última alimentação do banco de dados
  Future<void> _carregarUltimaAlimentacao() async {
    if (_database == null) {
      print('Banco de dados não está aberto corretamente');
      return; // Verifica se o banco de dados foi aberto corretamente
    }

    // Consulta o último registro da tabela Alimentação para o usuário atual
    List<Map<String, dynamic>> result = await _database.rawQuery(
      'SELECT ultima_alimentacao FROM Alimentacao WHERE id_pessoa = ? ORDER BY id DESC LIMIT 1',
      [widget.userId],
    );

    // Se houver resultados, atualiza o horário da última alimentação
    if (result.isNotEmpty) {
      setState(() {
        ultimaAlimentacao = result.first['ultima_alimentacao'];
      });
      print('Última alimentação carregada com sucesso: $ultimaAlimentacao');
    } else {
      print('Nenhum registro encontrado para o usuário ${widget.userId}');
    }
  }

  // Função para alimentar agora
  void _alimentarAgora() async {
    // Obtém o UID do usuário atualmente logado
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Acesso à coleção 'NivelComida' no Firestore
      CollectionReference nivelComidaCollection =
      FirebaseFirestore.instance.collection('NivelComida');

      // Consulta se existe um documento com o mesmo UID na coleção
      QuerySnapshot query =
      await nivelComidaCollection.where('userId', isEqualTo: uid).get();

      if (query.docs.isNotEmpty) {
        // Obtém o ID do documento existente
        String docId = query.docs.first.id;
        // Obtém o valor atual de nivelComida e converte para double
        double currentNivelComida =
        (query.docs.first['nivelComida'] as num).toDouble();

        // Verifica se o nivelComida é menor ou igual a 0
        if (currentNivelComida <= 0) {
          // Mostra um alerta pedindo para reabastecer o alimentador
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Atenção"),
                content: Text(
                    "O nível de comida está baixo. Por favor, reabasteça o alimentador."),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Subtrai 6,25 do valor atual
          double newNivelComida = currentNivelComida - 6.25;

          // Atualiza os dados do documento existente
          await nivelComidaCollection.doc(docId).update({
            'nivelComida': newNivelComida, // Atualiza o nível de comida subtraindo 6,25
            'timestamp': DateTime.now(), // Atualiza o timestamp
          });

          // Atualiza a variável global ultimaAlimentacao com o horário atual formatado
          ultimaAlimentacao =
          '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}';

          print('Dados atualizados no Firebase com sucesso.');
        }
      } else {
        print('Nenhum documento encontrado para o usuário $uid');
      }
    } catch (e) {
      // Em caso de erro, exibe uma mensagem
      print('Erro ao atualizar dados no Firebase: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erro"),
            content: Text("Erro ao atualizar dados no Firebase: $e"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Função para reabastecer o alimentador e inserir/atualizar dados no Firebase
  void _reabastecerAlimentador() async {
    // Obtém o UID do usuário atualmente logado
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Acesso à coleção 'NivelComida' no Firestore
      CollectionReference nivelComidaCollection = FirebaseFirestore.instance.collection('NivelComida');

      // Consulta se existe um documento com o mesmo UID na coleção
      QuerySnapshot query = await nivelComidaCollection.where('userId', isEqualTo: uid).get();

      // Se já existir um documento, atualiza o nível de comida e o timestamp
      if (query.docs.isNotEmpty) {
        // Obtém o ID do documento existente
        String docId = query.docs.first.id;

        // Atualiza os dados do documento existente
        await nivelComidaCollection.doc(docId).update({
          'nivelComida': 100, // Atualiza o nível de comida para 100
          'timestamp': DateTime.now(), // Atualiza o timestamp
        });

        print('Dados atualizados no Firebase com sucesso.');
      } else {
        // Se não existir documento, insere um novo
        await nivelComidaCollection.add({
          'userId': uid,
          'nivelComida': 100, // Define o nível de comida como 100
          'timestamp': DateTime.now(), // Adiciona o timestamp atual
        });

        print('Novo documento inserido no Firebase.');
      }
    } catch (e) {
      // Em caso de erro, exibe uma mensagem
      print('Erro ao inserir/atualizar dados no Firebase: $e');
    }
  }

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
                MaterialPageRoute(builder: (context) => telaperfil(userId: widget.userId)),
              );
            },
          ),
          // Ícone de logoff
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => telalogin()),
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
                          fontFamily: 'Roboto', // Usando a fonte Roboto
                          color: Colors.white, // Cor do texto
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
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
                            MaterialPageRoute(builder: (context) => horariosalimentacao(userId: widget.userId)),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFFE1EC2B)),
                          foregroundColor: MaterialStateProperty.all(Color(0xFFFA803F)),
                          side: MaterialStateProperty.all(BorderSide(
                            color: Color(0xFFE1EC2B),
                            width: 1,
                          )),
                        ),
                        child: Text('Programar Horário', style: TextStyle(fontSize: 15)),
                      ),
                      SizedBox(height: 10), // Espaçamento entre os botões
                      // Botão Alimentar Agora
                      ElevatedButton(
                        onPressed: () {
                          _alimentarAgora();
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
                      // Botão Reabastecer Alimentador
                      ElevatedButton(
                        onPressed: () {
                          _reabastecerAlimentador();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFFE1EC2B)), // Cor de fundo
                          foregroundColor: MaterialStateProperty.all(Color(0xFFFA803F)), // Cor do texto
                          side: MaterialStateProperty.all(BorderSide(
                            color: Color(0xFFE1EC2B), // Cor da borda
                            width: 1, // Largura da borda
                          )),
                        ),
                        child: Text('Reabastecer Alimentador', style: TextStyle(fontSize: 15)),
                      ),
                      SizedBox(height: 10), // Espaçamento entre os botões
                      // Botão Nível de Comida
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => telanivelcomida(userId: widget.userId)),
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
                  SizedBox(height: 200), // Espaçamento inferior de 200px para a última alimentação
                  // Texto "Última Alimentação"
                  Text(
                    'Última Alimentação: $ultimaAlimentacao', // Mostra o horário da última alimentação
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Tamanho da fonte para a última alimentação
                      fontFamily: 'Roboto', // Usando a fonte Roboto
                      color: Colors.white, // Cor do texto
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
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
  double nivelComidaAtual = 0.0; // Nível de comida atual (inicializado com 0)
  double capacidadeMaxima = 100.0; // Capacidade máxima do recipiente de comida

  @override
  void initState() {
    super.initState();
    _carregarNivelComidaAtual();
  }

  Future<void> _carregarNivelComidaAtual() async {
    // Obtém o UID do usuário atualmente logado
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Acesso à coleção 'NivelComida' no Firestore
      CollectionReference nivelComidaCollection = FirebaseFirestore.instance.collection('NivelComida');

      // Consulta se existe um documento com o mesmo UID na coleção
      QuerySnapshot query = await nivelComidaCollection.where('userId', isEqualTo: uid).get();

      if (query.docs.isNotEmpty) {
        // Obtém o ID do documento existente
        String docId = query.docs.first.id;
        // Obtém o valor atual de nivelComida e converte para double
        nivelComidaAtual = (query.docs.first['nivelComida'] as num).toDouble();

        // Atualiza o estado para refletir a mudança
        setState(() {});
      } else {
        print('Nenhum documento encontrado para o usuário ${widget.userId}');
      }
    } catch (e) {
      // Em caso de erro, exibe uma mensagem
      print('Erro ao atualizar dados no Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      color: Colors.white,
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
                        value: capacidadeMaxima != 0 ? nivelComidaAtual / capacidadeMaxima : 0.0,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.blue,
                        ),
                        strokeWidth: 10,
                      ),
                      Text(
                        '${(nivelComidaAtual / capacidadeMaxima * 100).toStringAsFixed(1)}%',
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
                    'Capacidade Máxima: ${capacidadeMaxima.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
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
  List<TextEditingController> nameControllers = [];
  List<TimeOfDay?> selectedTimes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Horários de Alimentação',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Color(0xFF045E83),
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Color(0xFFB4D6E0),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/water.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: nameControllers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: nameControllers[index],
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
                        ElevatedButton(
                          onPressed: () {
                            _selectTime(context, index);
                          },
                          child: Text(
                            selectedTimes[index]?.format(context) ?? 'Selecionar',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              nameControllers.length < 4 ? ElevatedButton(
                onPressed: _adicionarHorario,
                child: Text(
                  'Adicionar Horário',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
              ) : Text(
                'Limite de 4 horários alcançado',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _enviarDadosParaFirebase,
                child: Text(
                  'Enviar',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _adicionarHorario() {
    if (nameControllers.length < 4) {
      setState(() {
        nameControllers.add(TextEditingController());
        selectedTimes.add(null);
      });
    }
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        selectedTimes[index] = selectedTime;
      });
    }
  }

  void _enviarDadosParaFirebase() async {
    // Validar se todos os campos estão preenchidos
    if (!_validarCampos()) {
      // Exibir alerta informando que os campos devem ser preenchidos
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Campos Vazios'),
            content: Text('Por favor, preencha todos os campos antes de enviar.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fechar o AlertDialog
                },
              ),
            ],
          );
        },
      );
      return; // Abortar o envio dos dados
    }

    // Obter o UID do usuário atual (exemplo de obtenção, depende da autenticação que você está usando)
    String uid = FirebaseAuth.instance.currentUser!.uid; // Substitua pela lógica de obtenção do UID do usuário

    // Coleção onde os dados serão armazenados
    CollectionReference horariosCollection = FirebaseFirestore.instance.collection('Horarios');

    // Iterar sobre os controladores e os horários selecionados
    for (int i = 0; i < nameControllers.length; i++) {
      String nome = nameControllers[i].text;
      String hora = selectedTimes[i]?.format(context) ?? '';

      // Criar um mapa dos dados a serem enviados
      Map<String, dynamic> horarioData = {
        'nome': nome,
        'hora': hora,
        'userId': uid,
      };

      // Adicionar os dados ao Firestore
      try {
        await horariosCollection.add(horarioData);
        // Limpar os campos após a adição bem-sucedida, se necessário
        nameControllers[i].clear();
        setState(() {
          selectedTimes[i] = null;
        });
      } catch (e) {
        // Tratar erros de forma adequada (por exemplo, mostrando um SnackBar)
        print('Erro ao enviar horário: $e');
      }
    }

    // Mostrar um AlertDialog após a inserção
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Inserido com Sucesso'),
          content: Text('Os horários foram adicionados.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => menuprincipal(userId: uid)),
                );
              },
            ),
          ],
        );
      },
    );
  }

  bool _validarCampos() {
    for (var controller in nameControllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    for (var controller in nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String format(BuildContext context) {
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final String hourLabel = localizations.formatHour(this);
    final String minuteLabel = localizations.formatMinute(this);
    return '$hourLabel:$minuteLabel';
  }
}

