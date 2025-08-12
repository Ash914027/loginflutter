import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../repositories/picsum_repository.dart';
import '../blocs/images/images_bloc.dart';
import '../blocs/images/images_event.dart';
import '../blocs/images/images_state.dart';

class HomePage extends StatelessWidget {
  final PicsumRepository picsumRepository;
  const HomePage({super.key, required this.picsumRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImagesBloc(repository: picsumRepository)..add(const ImagesRequested(limit: 10)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Picsum Images')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: BlocBuilder<ImagesBloc, ImagesState>(
              builder: (context, state) {
                if (state.status == ImagesStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == ImagesStatus.failure) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state.images.isEmpty) {
                  return const Center(child: Text('No images'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  itemCount: state.images.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final img = state.images[index];
                    final aspect = img.width > 0 ? img.width / img.height : 1.0;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image with full width and dynamic height computed via AspectRatio
                        AspectRatio(
                          aspectRatio: aspect,
                          child: Image.network(
                            img.downloadUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return SizedBox(
                                height: 200,
                                child: Center(child: CircularProgressIndicator(value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1) : null)),
                              );
                            },
                            errorBuilder: (_, __, ___) => const SizedBox(height: 120, child: Center(child: Icon(Icons.broken_image))),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            img.author.isNotEmpty ? img.author : 'Unknown Author',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            'ID: ${img.id} • Original: ${img.downloadUrl}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 13, color: Colors.grey[700]),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
