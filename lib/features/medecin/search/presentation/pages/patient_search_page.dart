import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/routes/app_router.dart';

// Provider for search
final patientSearchQueryProvider = StateProvider<String>((ref) => '');

final patientSearchResultsProvider =
    FutureProvider<List<Patient>>((ref) async {
  final query = ref.watch(patientSearchQueryProvider);
  if (query.trim().length < 2) return [];

  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  final api = PatientsApi(clientAsync);
  try {
    final response = await api.getAllPatients(
      Pageable(page: 0, size: 20),
      query: query,
    );
    return response?.data?.content ?? [];
  } catch (_) {
    return [];
  }
});

class PatientSearchPage extends ConsumerStatefulWidget {
  const PatientSearchPage({super.key});

  @override
  ConsumerState<PatientSearchPage> createState() => _PatientSearchPageState();
}

class _PatientSearchPageState extends ConsumerState<PatientSearchPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(patientSearchResultsProvider);
    final query = ref.watch(patientSearchQueryProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text('Rechercher un patient'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(72),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Nom, prénom ou N° de carnet...',
                    prefixIcon: const Icon(Icons.search_outlined),
                    suffixIcon: query.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              ref
                                  .read(patientSearchQueryProvider.notifier)
                                  .state = '';
                            },
                          )
                        : null,
                  ),
                  onChanged: (v) =>
                      ref.read(patientSearchQueryProvider.notifier).state = v,
                ),
              ),
            ),
          ),

          // Results
          if (query.length < 2)
            SliverFillRemaining(
              child: _SearchHintState(),
            )
          else
            searchResults.when(
              data: (patients) => patients.isEmpty
                  ? SliverFillRemaining(child: _EmptySearchState(query: query))
                  : SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _PatientSearchCard(patient: patients[i]),
                          ),
                          childCount: patients.length,
                        ),
                      ),
                    ),
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => const SliverFillRemaining(
                child: Center(child: Text('Erreur de recherche')),
              ),
            ),
        ],
      ),
    );
  }
}

class _SearchHintState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_search_outlined,
              size: 64,
              color: AppColors.onSurfaceVariantLight.withAlpha(80)),
          const SizedBox(height: 16),
          Text(
            'Tapez au moins 2 caractères pour rechercher',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariantLight,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _EmptySearchState extends StatelessWidget {
  const _EmptySearchState({required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded,
              size: 64,
              color: AppColors.onSurfaceVariantLight.withAlpha(80)),
          const SizedBox(height: 16),
          Text('Aucun patient trouvé pour "$query"',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariantLight,
                  )),
        ],
      ),
    );
  }
}

class _PatientSearchCard extends StatelessWidget {
  const _PatientSearchCard({required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => context.push(AppRoutes.patientDossierPath(patient.id ?? '')),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark
                ? AppColors.outlineVariantDark
                : AppColors.outlineVariantLight,
          ),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'patient-avatar-${patient.id}',
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    patient.user?.nomComplet?.isNotEmpty == true
                        ? patient.user!.nomComplet![0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.user?.nomComplet ?? 'Patient',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 2),
                  if (patient.numeroCarnet != null)
                    Row(
                      children: [
                        const Icon(Icons.credit_card_outlined,
                            size: 13,
                            color: AppColors.onSurfaceVariantLight),
                        const SizedBox(width: 4),
                        Text(patient.numeroCarnet!,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  if (patient.groupeSanguin != null)
                    Row(
                      children: [
                        const Icon(Icons.water_drop_outlined,
                            size: 13, color: AppColors.heartRate),
                        const SizedBox(width: 4),
                        Text(
                          patient.groupeSanguin!.value.replaceAll('_', ''),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.heartRate),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 16, color: AppColors.onSurfaceVariantLight),
          ],
        ),
      ),
    );
  }
}
