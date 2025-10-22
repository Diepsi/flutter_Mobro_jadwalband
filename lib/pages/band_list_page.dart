import 'dart:io';
import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/band.dart';
import 'add_band_page.dart';

class BandListPage extends StatefulWidget {
  const BandListPage({super.key});

  @override
  _BandListPageState createState() => _BandListPageState();
}

class _BandListPageState extends State<BandListPage> {
  final DBHelper _dbHelper = DBHelper();
  List<Band> _bands = [];

  @override
  void initState() {
    super.initState();
    _loadBands();
  }

  Future<void> _loadBands() async {
    final bands = await _dbHelper.getBands();
    setState(() {
      _bands = bands;
    });
  }

  Future<void> _deleteBand(int id) async {
    await _dbHelper.deleteBand(id);
    _loadBands();
  }

  void _navigateToAddBandPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddBandPage()),
    );
    _loadBands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Band'),
      ),
      body: _bands.isEmpty
          ? const Center(child: Text('Belum ada band yang ditambahkan'))
          : ListView.builder(
              itemCount: _bands.length,
              itemBuilder: (context, index) {
                final band = _bands[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: band.imagePath.isNotEmpty
                        ? Image.file(
                            File(band.imagePath),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.music_note, size: 50),
                    title: Text(band.name),
                    subtitle: Text(
                        '${band.genre} | ${band.city} | ${band.date}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteBand(band.id!),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddBandPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
