import 'package:flutter/material.dart';

// --- MODEL DATA (STRUKTUR DATA) ---
// Kelas ini merepresentasikan satu acara/gig band.
class GigEvent {
  final String bandName;
  final String venue;
  final String date;
  final String city;
  final String description;
  final String posterUrl;

  GigEvent({
    required this.bandName,
    required this.venue,
    required this.date,
    required this.city,
    required this.description,
    required this.posterUrl,
  });
}

// --- MOCK DATA (DATA CONTOH SEMENTARA) ---
// Data ini bisa Anda ganti di masa depan dengan data dari API atau database.
final List<GigEvent> mockGigs = [
  GigEvent(
    bandName: "Efek Rumah Kaca",
    venue: "Creative Hall, Jakarta",
    date: "12 Januari 2026",
    city: "Jakarta",
    description: "Konser eksklusif merayakan 20 tahun karier band. Akan membawakan lagu-lagu dari album pertama hingga terbaru.",
    posterUrl: "https://placehold.co/600x400/3c3b6e/ffffff?text=ERK+20+Tahun",
  ),
  GigEvent(
    bandName: "Fourtwnty",
    venue: "Amphitheater, Bandung",
    date: "28 Februari 2026",
    city: "Bandung",
    description: "Pertunjukan akustik di udara terbuka. Nikmati senja dengan alunan musik santai yang menenangkan jiwa.",
    posterUrl: "https://placehold.co/600x400/4CAF50/ffffff?text=Fourtwnty+Akustik",
  ),
  GigEvent(
    bandName: "Sheila On 7",
    venue: "Stadion Kridosono, Yogyakarta",
    date: "15 Maret 2026",
    city: "Yogyakarta",
    description: "Konser reuni besar di kota asal mereka. Dimeriahkan oleh berbagai penampilan kejutan dari musisi lokal.",
    posterUrl: "https://placehold.co/600x400/FF5722/ffffff?text=SO7+Reuni+Besar",
  ),
  GigEvent(
    bandName: "Seringai",
    venue: "Gedung Balai Kota, Surabaya",
    date: "05 April 2026",
    city: "Surabaya",
    description: "Riff-riff keras dan energi maksimal! Malam penuh headbanging untuk para serigala ibu kota.",
    posterUrl: "https://placehold.co/600x400/F44336/ffffff?text=Seringai+Rockerz",
  ),
];

// --- MAIN APP WIDGET ---
void main() {
  runApp(const JadwalBandApp());
}

class JadwalBandApp extends StatelessWidget {
  const JadwalBandApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Pengaturan tema dasar aplikasi (Monokrom)
    return MaterialApp(
      title: 'Jadwal Gigs Indonesia',
      theme: ThemeData(
        // Menggunakan Colors.grey sebagai base untuk skema monokrom
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 1,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black, // Warna ikon dan teks AppBar
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// --- HOME PAGE (HALAMAN UTAMA) ---
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Band Indonesia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implementasi fitur pencarian di masa depan
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur Pencarian segera hadir!')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: mockGigs.length,
        itemBuilder: (context, index) {
          final gig = mockGigs[index];
          return GigCard(gig: gig);
        },
      ),
      // Tombol Aksi Melayang (FAB)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Anda menekan tombol Tambah Jadwal.')),
          );
        },
        label: const Text('Tambah Jadwal'),
        icon: const Icon(Icons.add_a_photo),
        backgroundColor: Colors.black, // FAB berwarna hitam
        foregroundColor: Colors.white,
      ),
    );
  }
}

// --- CARD WIDGET UNTUK DAFTAR GIGS ---
class GigCard extends StatelessWidget {
  final GigEvent gig;

  const GigCard({required this.gig, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          // Navigasi ke Halaman Detail saat Card diklik
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GigDetailPage(gig: gig),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Poster (Menggunakan Placeholder)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                gig.posterUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                // Error handling untuk placeholder
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey.shade200, // Warna latar abu-abu muda
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.music_note, size: 40, color: Colors.black), // Ikon hitam
                        Text('Poster Tidak Ditemukan', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Band dan Judul Acara
                  Text(
                    gig.bandName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.black, // Teks judul hitam
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Informasi Lokasi dan Tanggal
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: Colors.black54), // Ikon abu-abu gelap
                      const SizedBox(width: 5),
                      Text(
                        gig.date,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.black54), // Ikon abu-abu gelap
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          '${gig.venue}, ${gig.city}',
                          style: const TextStyle(color: Colors.black54), // Teks abu-abu gelap
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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

// --- DETAIL PAGE (HALAMAN DETAIL GIG) ---
class GigDetailPage extends StatelessWidget {
  final GigEvent gig;

  const GigDetailPage({required this.gig, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gig.bandName),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Poster Detail
            Image.network(
              gig.posterUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey.shade200, // Warna latar abu-abu muda
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, size: 50, color: Colors.black), // Ikon hitam
                      Text('Poster Detail Tidak Tersedia', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Konser ${gig.bandName}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.black, // Teks judul hitam
                    ),
                  ),
                  const Divider(height: 30, thickness: 2, color: Colors.black12), // Divider abu-abu tipis

                  // Kartu Detail Informasi
                  _buildDetailCard(
                    icon: Icons.calendar_month,
                    title: 'Tanggal & Waktu',
                    subtitle: gig.date,
                  ),
                  _buildDetailCard(
                    icon: Icons.location_city,
                    title: 'Kota',
                    subtitle: gig.city,
                  ),
                  _buildDetailCard(
                    icon: Icons.place,
                    title: 'Lokasi',
                    subtitle: gig.venue,
                  ),
                  const SizedBox(height: 20),

                  // Deskripsi
                  Text(
                    'Tentang Acara:',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, // Teks sub-judul hitam
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    gig.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 30),

                  // Tombol Aksi
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Membuka halaman pembelian tiket... (Fitur Belum Diimplementasi)')),
                        );
                      },
                      icon: const Icon(Icons.credit_card),
                      label: const Text('Beli Tiket Sekarang'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.black, // Tombol berwarna hitam
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
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

  // Widget pembantu untuk tampilan detail (informasi Tanggal, Kota, Lokasi)
  Widget _buildDetailCard({required IconData icon, required String title, required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.black54), // Ikon abu-abu gelap
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tanggal & Waktu',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
