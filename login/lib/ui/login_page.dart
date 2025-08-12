// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../repositories/picsum_repository.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final PicsumRepository picsumRepository;
  const LoginPage({super.key, required this.picsumRepository});

  @override State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.success) {
              // navigate to home
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => HomePage(picsumRepository: widget.picsumRepository),
                ),
              );
            } else if (state.status == AuthStatus.failure) {
              final msg = state.message ?? 'Login failed';
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 24),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (v) {
                    _email = v;
                    authBloc.add(AuthEmailChanged(v));
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email required';
                    final ok = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(v);
                    return ok ? null : 'Invalid email';
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (v) {
                    _password = v;
                    authBloc.add(AuthPasswordChanged(v));
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password required';
                    final rx = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
                    return rx.hasMatch(v) ? null : 'Password must be 8+ with upper, lower, digit and symbol';
                  },
                ),
                const SizedBox(height: 24),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.status == AuthStatus.submitting ? null : _onSubmit,
                        child: state.status == AuthStatus.submitting
                            ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('Submit'),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    BlocProvider.of<AuthBloc>(context).add(AuthSubmitted(_email, _password));
  }
}
