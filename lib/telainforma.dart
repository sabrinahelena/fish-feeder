import 'package:flutter/material.dart';

class telainforma extends StatefulWidget {
  const telainforma({Key? key}) : super(key: key);

  @override
  _telainformaState createState() => _telainformaState();
}

class _telainformaState extends State<telainforma> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cuidados com o Peixe",
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Como Cuidar de um Peixe:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1. Escolha um tanque adequado e mantenha a água limpa.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Text(
              '- Escolha um aquário adequado para o tamanho e quantidade de peixes.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Text(
              '- Posicione o aquário em um local estável, longe de correntes de ar e luz solar direta.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Text(
              '2. Alimentação:',
              style: TextStyle(height: 10),
              textAlign: TextAlign.justify,
            ),
            Text(
              '- Alimente os peixes com uma dieta equilibrada e específica para a espécie.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Text(
              '- Alimente o peixe regularmente, mas não em excesso.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Text(
              '3. Temperatura da água:',
              style: TextStyle(height: 10),
              textAlign: TextAlign.justify,
            ),
            Text(
              '- Mantenha a temperatura da água dentro da faixa adequada para a espécie de peixe que você possui.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Text(
              '- Use um termômetro para monitorar a temperatura regularmente.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Text(
              '4. Limpeza da água:',
              style: TextStyle(height: 10),
              textAlign: TextAlign.justify,
            ),
            Text(
              '- Realize trocas parciais de água regularmente para remover resíduos e substâncias indesejadas.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Text(
              '- Limpe o filtro do aquário conforme as instruções do fabricante para garantir seu bom funcionamento.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Text(
              '5. Observação:',
              style: TextStyle(height: 10),
            ),
            Text(
              '- Observe os peixes regularmente quanto a mudanças de comportamento, como falta de apetite, isolamento ou natação anormal.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const Text(
              '- Procure sinais visíveis de doenças, como manchas, feridas, parasitas ou mudanças na coloração.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text(
              'Dicas Adicionais:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '- Evite mudanças bruscas no ambiente do tanque.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Text(
              '- Introduza novos peixes com cuidado para evitar conflitos territoriais.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Text(
              '- Realize testes regulares de qualidade da água.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleVoltarButtonPressed,
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleVoltarButtonPressed() {
    // Implemente a ação desejada ao pressionar o botão
    }
}
