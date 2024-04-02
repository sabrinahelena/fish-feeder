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
            color: Colors.black,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 25,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Colors.transparent, // Tornando a barra de aplicativos transparente
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

void _handleVoltarButtonPressed() {
    // Implemente a ação desejada ao pressionar o botão
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Nível de Comida Atual:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
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
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Capacidade Máxima: $capacidadeMaxima%', // Exibe a capacidade máxima do recipiente de comida
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
