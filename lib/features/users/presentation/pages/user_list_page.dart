import 'package:auto_route/auto_route.dart';
import 'package:clean_arch_app/core/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:data_table_2/data_table_2.dart';

@RoutePage()
class UsersListPage extends ConsumerStatefulWidget {
  const UsersListPage({super.key});

  @override
  ConsumerState<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends ConsumerState<UsersListPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'all';
  String _selectedRole = 'all';
  DateTime? _dateFrom;
  DateTime? _dateTo;
  
  // мок данные пока
  final List<UserData> _users = List.generate(50, (index) => UserData(
    id: index + 1,
    name: 'Пользователь ${index + 1}',
    email: 'user${index + 1}@example.com',
    phone: '+7900${1000000 + index}',
    status: index % 3 == 0 ? 'active' : index % 3 == 1 ? 'blocked' : 'pending',
    role: index % 4 == 0 ? 'admin' : index % 4 == 1 ? 'manager' : 'user',
    registrationDate: DateTime.now().subtract(Duration(days: index * 3)),
    bonusBalance: 1000 + index * 50,
    checksCount: index * 3,
  ));
  
  List<UserData> get filteredUsers {
    return _users.where((user) {
      // поиск
      if (_searchController.text.isNotEmpty) {
        final query = _searchController.text.toLowerCase();
        if (!user.name.toLowerCase().contains(query) &&
            !user.email.toLowerCase().contains(query) &&
            !user.phone.contains(query)) {
          return false;
        }
      }
      
      // фильтр по статусу
      if (_selectedStatus != 'all' && user.status != _selectedStatus) {
        return false;
      }
      
      // фильтр по роли
      if (_selectedRole != 'all' && user.role != _selectedRole) {
        return false;
      }
      
      // фильтр по дате
      if (_dateFrom != null && user.registrationDate.isBefore(_dateFrom!)) {
        return false;
      }
      if (_dateTo != null && user.registrationDate.isAfter(_dateTo!)) {
        return false;
      }
      
      return true;
    }).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // заголовок и кнопки
            Row(
              children: [
                Text(
                  'Пользователи',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_users.length} всего',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Spacer(),
                // кнопки действий
                IconButton(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.download),
                  tooltip: 'Экспорт',
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.upload),
                  tooltip: 'Импорт',
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _showAddUserDialog(),
                  icon: const Icon(LucideIcons.userPlus, size: 18),
                  label: const Text('Добавить пользователя'),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // фильтры
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.dividerColor.withOpacity(0.1),
                ),
              ),
              child: Row(
                children: [
                  // поиск
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Поиск по имени, email или телефону...',
                        prefixIcon: const Icon(LucideIcons.search, size: 20),
                        suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(LucideIcons.x, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: theme.dividerColor.withOpacity(0.2),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // фильтр по статусу
                  SizedBox(
                    width: 150,
                    child: DropdownButtonFormField<String>(
                      value: _selectedStatus,
                      onChanged: (value) {
                        setState(() => _selectedStatus = value!);
                      },
                      decoration: InputDecoration(
                        labelText: 'Статус',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'all', child: Text('Все')),
                        DropdownMenuItem(value: 'active', child: Text('Активные')),
                        DropdownMenuItem(value: 'blocked', child: Text('Заблокированы')),
                        DropdownMenuItem(value: 'pending', child: Text('Ожидают')),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // фильтр по роли
                  SizedBox(
                    width: 150,
                    child: DropdownButtonFormField<String>(
                      value: _selectedRole,
                      onChanged: (value) {
                        setState(() => _selectedRole = value!);
                      },
                      decoration: InputDecoration(
                        labelText: 'Роль',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'all', child: Text('Все')),
                        DropdownMenuItem(value: 'admin', child: Text('Админ')),
                        DropdownMenuItem(value: 'manager', child: Text('Менеджер')),
                        DropdownMenuItem(value: 'user', child: Text('Пользователь')),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // кнопка сброса фильтров
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _selectedStatus = 'all';
                        _selectedRole = 'all';
                        _dateFrom = null;
                        _dateTo = null;
                      });
                    },
                    icon: const Icon(LucideIcons.filterX, size: 18),
                    label: const Text('Сбросить'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // таблица
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.dividerColor.withOpacity(0.1),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 1200,
                    columns: [
                      DataColumn2(
                        label: const Text('ID'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: const Text('Имя'),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: const Text('Email'),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: const Text('Телефон'),
                        size: ColumnSize.M,
                      ),
                      DataColumn2(
                        label: const Text('Статус'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: const Text('Роль'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: const Text('Бонусы'),
                        size: ColumnSize.S,
                        numeric: true,
                      ),
                      DataColumn2(
                        label: const Text('Чеков'),
                        size: ColumnSize.S,
                        numeric: true,
                      ),
                      DataColumn2(
                        label: const Text('Регистрация'),
                        size: ColumnSize.M,
                      ),
                      DataColumn2(
                        label: const Text('Действия'),
                        size: ColumnSize.S,
                        fixedWidth: 100,
                      ),
                    ],
                    rows: filteredUsers.map((user) => DataRow2(
                      onTap: () => _showUserDetails(user),
                      cells: [
                        DataCell(Text('#${user.id}')),
                        DataCell(
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                                child: Text(
                                  user.name.substring(0, 2).toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(user.name),
                            ],
                          ),
                        ),
                        DataCell(Text(user.email)),
                        DataCell(Text(user.phone)),
                        DataCell(_buildStatusChip(user.status)),
                        DataCell(_buildRoleChip(user.role)),
                        DataCell(
                          Text(
                            '${user.bonusBalance}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        DataCell(Text('${user.checksCount}')),
                        DataCell(
                          Text(
                            '${user.registrationDate.day.toString().padLeft(2, '0')}.${user.registrationDate.month.toString().padLeft(2, '0')}.${user.registrationDate.year}',
                          ),
                        ),
                        DataCell(
                          PopupMenuButton<String>(
                            icon: const Icon(LucideIcons.moreVertical, size: 18),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'view',
                                child: Row(
                                  children: [
                                    Icon(LucideIcons.eye, size: 16),
                                    SizedBox(width: 8),
                                    Text('Просмотр'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(LucideIcons.edit, size: 16),
                                    SizedBox(width: 8),
                                    Text('Изменить'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'block',
                                child: Row(
                                  children: [
                                    Icon(LucideIcons.ban, size: 16),
                                    SizedBox(width: 8),
                                    Text('Заблокировать'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(LucideIcons.trash2, size: 16, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Удалить', style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                            ],
                            onSelected: (value) => _handleAction(value, user),
                          ),
                        ),
                      ],
                    )).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatusChip(String status) {
    Color color;
    String text;
    IconData icon;
    
    switch (status) {
      case 'active':
        color = Colors.green;
        text = 'Активен';
        icon = LucideIcons.checkCircle;
        break;
      case 'blocked':
        color = Colors.red;
        text = 'Заблокирован';
        icon = LucideIcons.xCircle;
        break;
      case 'pending':
        color = Colors.orange;
        text = 'Ожидает';
        icon = LucideIcons.clock;
        break;
      default:
        color = Colors.grey;
        text = status;
        icon = LucideIcons.circle;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRoleChip(String role) {
    Color color;
    String text;
    
    switch (role) {
      case 'admin':
        color = Colors.purple;
        text = 'Админ';
        break;
      case 'manager':
        color = Colors.blue;
        text = 'Менеджер';
        break;
      case 'user':
        color = Colors.grey;
        text = 'Пользователь';
        break;
      default:
        color = Colors.grey;
        text = role;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  
  void _handleAction(String action, UserData user) {
    switch (action) {
      case 'view':
        _showUserDetails(user);
        break;
      case 'edit':
        _showEditUserDialog(user);
        break;
      case 'block':
        _showBlockConfirmation(user);
        break;
      case 'delete':
        _showDeleteConfirmation(user);
        break;
    }
  }
  
  void _showUserDetails(UserData user) {
    // тут переход на детальную страницу
    context.router.push(UserDetailRoute(userId: user.id));
  }
  
  void _showAddUserDialog() {
    // диалог добавления пользователя
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить пользователя'),
        content: const SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Имя',
                  prefixIcon: Icon(LucideIcons.user),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(LucideIcons.mail),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Телефон',
                  prefixIcon: Icon(LucideIcons.phone),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              // сохранение
              Navigator.of(context).pop();
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
  
  void _showEditUserDialog(UserData user) {
    // диалог редактирования
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Редактировать: ${user.name}'),
        content: const Text('Форма редактирования...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
  
  void _showBlockConfirmation(UserData user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Заблокировать пользователя?'),
        content: Text('Вы уверены, что хотите заблокировать ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // блокировка
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Заблокировать'),
          ),
        ],
      ),
    );
  }
  
  void _showDeleteConfirmation(UserData user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить пользователя?'),
        content: Text('Это действие нельзя отменить. Удалить ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // удаление
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// модель данных
class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String status;
  final String role;
  final DateTime registrationDate;
  final int bonusBalance;
  final int checksCount;
  
  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.role,
    required this.registrationDate,
    required this.bonusBalance,
    required this.checksCount,
  });
}