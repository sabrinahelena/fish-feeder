import 'package:flutter/material.dart';

class telanivelcomida extends StatefulWidget {
  const telanivelcomida({Key? key}) : super(key: key);

  @override
  _telaNivelComida createState() => _telaNivelComida();
}



class _telaNivelComida extends State<telanivelcomida> {
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