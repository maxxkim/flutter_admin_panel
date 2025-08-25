import 'package:auto_route/auto_route.dart';
import 'package:clean_arch_app/core/router/app_router.dart';
import 'package:clean_arch_app/features/users/presentation/providers/user_provider.dart';
import 'package:clean_arch_app/features/users/presentation/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class UsersListPage extends ConsumerWidget {
  const UsersListPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersListProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: usersAsync.when(
        data: (users) => RefreshIndicator(
          onRefresh: () => ref.refresh(usersListProvider.future),
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return UserCard(
                user: user,
                onTap: () {
                  context.router.push(UserDetailRoute(userId: user.id));
                },
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error: ${error.toString()}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(usersListProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}