import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    // TODO: appeler l'API de réinitialisation de mot de passe
    setState(() => _sent = true);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(
              gradient: isDark
                  ? AppColors.darkHeroGradient
                  : AppColors.heroGradient,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.go(AppRoutes.login),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Mot de passe oublié',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Card
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceDark
                          : AppColors.surfaceLight,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(30),
                          blurRadius: 40,
                          offset: const Offset(0, -8),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(28, 32, 28, 24),
                      child: _sent ? _SuccessView(context) : _FormView(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _FormView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.lock_reset_rounded, size: 56, color: AppColors.primary),
          const SizedBox(height: 20),
          Text(
            'Réinitialiser votre mot de passe',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Entrez votre adresse email et nous vous enverrons un lien pour réinitialiser votre mot de passe.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariantLight,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            decoration: const InputDecoration(
              labelText: 'Adresse email',
              hintText: 'exemple@email.com',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Champ requis';
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                return 'Email invalide';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 56,
            child: FilledButton(
              onPressed: _submit,
              child: const Text('Envoyer le lien'),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => context.go(AppRoutes.login),
            child: const Text('Retour à la connexion'),
          ),
        ],
      ),
    );
  }

  Widget _SuccessView(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 40),
        const Icon(Icons.mark_email_read_rounded,
            size: 72, color: Colors.green),
        const SizedBox(height: 24),
        Text(
          'Email envoyé !',
          style: Theme.of(ctx).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Vérifiez votre boîte mail et suivez les instructions pour réinitialiser votre mot de passe.',
          style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurfaceVariantLight,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 56,
          child: FilledButton(
            onPressed: () => context.go(AppRoutes.login),
            child: const Text('Retour à la connexion'),
          ),
        ),
      ],
    );
  }
}
