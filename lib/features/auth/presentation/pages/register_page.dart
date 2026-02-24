import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Communs
  final _nomCompletController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telephoneController = TextEditingController();
  bool _obscurePassword = true;
  String _selectedRole = 'PATIENT';

  // Patient
  DateTime? _dateNaissance;
  String _genre = 'M';

  // Médecin
  final _specialiteController = TextEditingController();
  final _numeroOrdreController = TextEditingController();
  final _carteProController = TextEditingController();

  bool _isSubmitting = false;
  String? _errorMessage;
  bool _success = false;

  @override
  void dispose() {
    _nomCompletController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _telephoneController.dispose();
    _specialiteController.dispose();
    _numeroOrdreController.dispose();
    _carteProController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedRole == 'PATIENT' && _dateNaissance == null) {
      setState(() => _errorMessage = 'Veuillez sélectionner votre date de naissance');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    FocusScope.of(context).unfocus();

    final error = await ref.read(authProvider.notifier).register(
          role: _selectedRole,
          nomComplet: _nomCompletController.text.trim(),
          email: _emailController.text.trim(),
          motDePasse: _passwordController.text,
          telephone: _telephoneController.text.trim().isEmpty
              ? null
              : _telephoneController.text.trim(),
          // Patient
          dateNaissance: _dateNaissance,
          genre: _genre,
          // Médecin
          specialite: _specialiteController.text.trim().isEmpty
              ? null
              : _specialiteController.text.trim(),
          numeroOrdre: _numeroOrdreController.text.trim().isEmpty
              ? null
              : _numeroOrdreController.text.trim(),
          numeroCarteProfessionnelle: _carteProController.text.trim().isEmpty
              ? null
              : _carteProController.text.trim(),
        );

    if (!mounted) return;

    if (error == null) {
      setState(() {
        _isSubmitting = false;
        _success = true;
      });
    } else {
      setState(() {
        _isSubmitting = false;
        _errorMessage = error;
      });
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 25),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year - 5),
      helpText: 'Date de naissance',
      locale: const Locale('fr'),
    );
    if (picked != null) setState(() => _dateNaissance = picked);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.32,
            decoration: BoxDecoration(
              gradient: isDark
                  ? AppColors.darkHeroGradient
                  : AppColors.heroGradient,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // ── Header ──
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
                        'Créer un compte',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Card ──
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
                    child: _success
                        ? _buildSuccess()
                        : SingleChildScrollView(
                            padding:
                                const EdgeInsets.fromLTRB(28, 28, 28, 40),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Sélecteur de rôle
                                  _RoleSelector(
                                    selected: _selectedRole,
                                    onChanged: (r) =>
                                        setState(() => _selectedRole = r),
                                  ),
                                  const SizedBox(height: 24),

                                  // Bannière d'erreur
                                  if (_errorMessage != null) ...[
                                    _ErrorBanner(message: _errorMessage!),
                                    const SizedBox(height: 16),
                                  ],

                                  // ── Champs communs ──
                                  _buildTextField(
                                    controller: _nomCompletController,
                                    label: 'Nom complet',
                                    icon: Icons.badge_outlined,
                                    action: TextInputAction.next,
                                    capitalization: TextCapitalization.words,
                                    validator: _required,
                                  ),
                                  const SizedBox(height: 14),
                                  _buildTextField(
                                    controller: _emailController,
                                    label: 'Adresse email',
                                    icon: Icons.email_outlined,
                                    action: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        return 'Champ requis';
                                      }
                                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(v)) {
                                        return 'Email invalide';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                  _buildTextField(
                                    controller: _telephoneController,
                                    label: 'Téléphone (optionnel)',
                                    icon: Icons.phone_outlined,
                                    action: TextInputAction.next,
                                    keyboardType: TextInputType.phone,
                                  ),
                                  const SizedBox(height: 14),

                                  // Mot de passe
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Mot de passe',
                                      prefixIcon:
                                          const Icon(Icons.lock_outline),
                                      suffixIcon: IconButton(
                                        icon: Icon(_obscurePassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined),
                                        onPressed: () => setState(() =>
                                            _obscurePassword =
                                                !_obscurePassword),
                                      ),
                                    ),
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        return 'Champ requis';
                                      }
                                      if (v.length < 6) {
                                        return 'Au moins 6 caractères';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),

                                  // ── Champs spécifiques au rôle ──
                                  if (_selectedRole == 'PATIENT')
                                    _buildPatientFields()
                                  else
                                    _buildMedecinFields(),

                                  const SizedBox(height: 28),

                                  // Bouton soumettre
                                  SizedBox(
                                    height: 56,
                                    child: FilledButton(
                                      onPressed: _isSubmitting ? null : _submit,
                                      child: _isSubmitting
                                          ? const SizedBox(
                                              width: 22,
                                              height: 22,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.5,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text('Créer mon compte'),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Déjà un compte ? ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            context.go(AppRoutes.login),
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: const Text('Se connecter'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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

  // ── Champs Patient ──────────────────────────────────────────────

  Widget _buildPatientFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Date de naissance
        GestureDetector(
          onTap: _pickDate,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Date de naissance *',
              prefixIcon: const Icon(Icons.cake_outlined),
              suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
              errorText: _dateNaissance == null && _isSubmitting
                  ? 'Champ requis'
                  : null,
            ),
            child: Text(
              _dateNaissance != null
                  ? DateFormat('dd/MM/yyyy').format(_dateNaissance!)
                  : 'Sélectionner une date',
              style: TextStyle(
                color: _dateNaissance != null
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).hintColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Genre
        Text(
          'Genre',
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _GenreChip(
                label: 'Homme',
                value: 'M',
                selected: _genre == 'M',
                onTap: () => setState(() => _genre = 'M')),
            const SizedBox(width: 10),
            _GenreChip(
                label: 'Femme',
                value: 'F',
                selected: _genre == 'F',
                onTap: () => setState(() => _genre = 'F')),
            const SizedBox(width: 10),
            _GenreChip(
                label: 'Autre',
                value: 'AUTRE',
                selected: _genre == 'AUTRE',
                onTap: () => setState(() => _genre = 'AUTRE')),
          ],
        ),
      ],
    );
  }

  // ── Champs Médecin ──────────────────────────────────────────────

  Widget _buildMedecinFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField(
          controller: _specialiteController,
          label: 'Spécialité *',
          icon: Icons.medical_services_outlined,
          action: TextInputAction.next,
          capitalization: TextCapitalization.words,
          validator: _required,
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _numeroOrdreController,
          label: 'Numéro d\'ordre *',
          icon: Icons.numbers_outlined,
          action: TextInputAction.next,
          validator: _required,
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _carteProController,
          label: 'Numéro carte professionnelle (optionnel)',
          icon: Icons.credit_card_outlined,
          action: TextInputAction.done,
        ),
      ],
    );
  }

  // ── Écran de succès ─────────────────────────────────────────────

  Widget _buildSuccess() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_rounded,
                size: 80, color: Colors.green),
            const SizedBox(height: 24),
            const Text(
              'Compte créé avec succès !',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              _selectedRole == 'PATIENT'
                  ? 'Votre compte patient a été créé. Vous pouvez maintenant vous connecter.'
                  : 'Votre compte médecin a été créé. Il est en attente de validation par l\'administration.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariantLight,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () => context.go(AppRoutes.login),
                child: const Text('Se connecter'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────────────

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputAction action = TextInputAction.next,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization capitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: action,
      textCapitalization: capitalization,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      validator: validator,
    );
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Champ requis' : null;
}

// ── Widgets extraits ──────────────────────────────────────────────

class _RoleSelector extends StatelessWidget {
  const _RoleSelector({required this.selected, required this.onChanged});
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _RoleChip(
          label: 'Patient',
          icon: Icons.person_outline,
          selected: selected == 'PATIENT',
          onTap: () => onChanged('PATIENT'),
        ),
        const SizedBox(width: 12),
        _RoleChip(
          label: 'Médecin',
          icon: Icons.local_hospital_outlined,
          selected: selected == 'MEDECIN',
          onTap: () => onChanged('MEDECIN'),
        ),
      ],
    );
  }
}

class _RoleChip extends StatelessWidget {
  const _RoleChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.outline;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).colorScheme.primaryContainer
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color, width: selected ? 2 : 1),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  const _GenreChip({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).colorScheme.primaryContainer
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
              width: selected ? 2 : 1,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withAlpha(80)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppColors.error, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: AppColors.errorDark,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
