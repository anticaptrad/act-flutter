import 'package:flutter/material.dart';

const Color _acid = Color(0xFFADFF2F);
const Color _cyan = Color(0xFF66D9FF);
const Color _canvas = Color(0xFF090B10);
const Color _surface = Color(0xFF11151D);
const Color _raisedSurface = Color(0xFF181E28);
const Color _border = Color(0xFF2A3240);

class AntiCapTradApp extends StatelessWidget {
  const AntiCapTradApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = ColorScheme.fromSeed(
      seedColor: _acid,
      brightness: Brightness.dark,
      surface: _surface,
    );

    return MaterialApp(
      title: 'AntiCapTrad Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: colors,
        scaffoldBackgroundColor: _canvas,
        cardColor: _surface,
        dividerColor: _border,
        useMaterial3: true,
        textTheme: Typography.whiteCupertino.apply(
          bodyColor: const Color(0xFFF2F5F7),
          displayColor: const Color(0xFFF2F5F7),
        ),
      ),
      home: const StudioShell(),
    );
  }
}

class StudioShell extends StatefulWidget {
  const StudioShell({super.key});

  @override
  State<StudioShell> createState() => _StudioShellState();
}

class _StudioShellState extends State<StudioShell> {
  int _selectedPage = 0;
  final Set<String> _armedDestinations = <String>{};

  static const List<NavigationDestination> _destinations =
      <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.videocam_outlined),
          selectedIcon: Icon(Icons.videocam),
          label: 'Studio',
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_month_outlined),
          selectedIcon: Icon(Icons.calendar_month),
          label: 'Schedule',
        ),
        NavigationDestination(
          icon: Icon(Icons.video_library_outlined),
          selectedIcon: Icon(Icons.video_library),
          label: 'Library',
        ),
        NavigationDestination(
          icon: Icon(Icons.tune_outlined),
          selectedIcon: Icon(Icons.tune),
          label: 'Settings',
        ),
      ];

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  void _setDestinationArmed(String name, {required bool armed}) {
    setState(() {
      if (armed) {
        _armedDestinations.add(name);
      } else {
        _armedDestinations.remove(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool desktop = constraints.maxWidth >= 900;
        final Widget page = _selectedPage == 0
            ? StudioDashboard(
                armedDestinations: _armedDestinations,
                onDestinationChanged: _setDestinationArmed,
              )
            : PlaceholderPage(label: _destinations[_selectedPage].label);

        if (!desktop) {
          return Scaffold(
            appBar: const StudioAppBar(),
            body: page,
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedPage,
              destinations: _destinations,
              onDestinationSelected: _selectPage,
            ),
          );
        }

        return Scaffold(
          body: Row(
            children: <Widget>[
              SafeArea(
                child: NavigationRail(
                  selectedIndex: _selectedPage,
                  onDestinationSelected: _selectPage,
                  extended: constraints.maxWidth >= 1180,
                  backgroundColor: _surface,
                  leading: const Padding(
                    padding: EdgeInsets.only(bottom: 28),
                    child: BrandMark(),
                  ),
                  destinations: _destinations
                      .map(
                        (NavigationDestination destination) =>
                            NavigationRailDestination(
                              icon: destination.icon,
                              selectedIcon: destination.selectedIcon,
                              label: Text(destination.label),
                            ),
                      )
                      .toList(growable: false),
                ),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: Column(
                  children: <Widget>[
                    const StudioAppBar(),
                    Expanded(child: page),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class StudioAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StudioAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _canvas,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 68,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Broadcast workspace',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Adaptive mobile + desktop control plane',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF9BA7B4),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const _IdentityChip(),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Notifications',
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _acid,
        borderRadius: BorderRadius.circular(13),
      ),
      child: const Text(
        'ACT',
        style: TextStyle(
          color: Color(0xFF071000),
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class StudioDashboard extends StatelessWidget {
  const StudioDashboard({
    required this.armedDestinations,
    required this.onDestinationChanged,
    super.key,
  });

  final Set<String> armedDestinations;
  final void Function(String name, {required bool armed}) onDestinationChanged;

  static const List<BroadcastDestination> destinations = <BroadcastDestination>[
    BroadcastDestination('YouTube', 'RTMPS + Data API', Color(0xFFFF5277)),
    BroadcastDestination('Twitch', 'RTMPS + EventSub', Color(0xFFB69CFF)),
    BroadcastDestination('Rumble', 'RTMP + API', Color(0xFF8EDB4D)),
    BroadcastDestination('StreamYard', 'Studio handoff', Color(0xFF6AA8FF)),
    BroadcastDestination('X / Twitter', 'Publisher API', Color(0xFFD7E0E8)),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool twoColumns = constraints.maxWidth >= 780;
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (twoColumns)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Expanded(flex: 7, child: ProgramMonitor()),
                    const SizedBox(width: 18),
                    Expanded(
                      flex: 4,
                      child: DestinationPanel(
                        destinations: destinations,
                        armedDestinations: armedDestinations,
                        onChanged: onDestinationChanged,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const ProgramMonitor(),
                    const SizedBox(height: 18),
                    DestinationPanel(
                      destinations: destinations,
                      armedDestinations: armedDestinations,
                      onChanged: onDestinationChanged,
                    ),
                  ],
                ),
              const SizedBox(height: 18),
              const TransportPanel(),
            ],
          ),
        );
      },
    );
  }
}

class ProgramMonitor extends StatelessWidget {
  const ProgramMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Row(
            children: <Widget>[
              _SectionLabel('PROGRAM MONITOR'),
              Spacer(),
              _StatusChip(label: 'OFF AIR', color: Color(0xFFFF7198)),
            ],
          ),
          const SizedBox(height: 14),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFF050608),
                border: Border.all(color: const Color(0xFF202631)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: _raisedSurface,
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 40,
                        color: _cyan,
                      ),
                    ),
                    SizedBox(height: 18),
                    Text(
                      'Select a camera, screen, or contribution feed',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF9BA7B4)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DestinationPanel extends StatelessWidget {
  const DestinationPanel({
    required this.destinations,
    required this.armedDestinations,
    required this.onChanged,
    super.key,
  });

  final List<BroadcastDestination> destinations;
  final Set<String> armedDestinations;
  final void Function(String name, {required bool armed}) onChanged;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionLabel('DESTINATIONS'),
          const SizedBox(height: 14),
          for (final BroadcastDestination destination
              in destinations) ...<Widget>[
            _DestinationRow(
              destination: destination,
              armed: armedDestinations.contains(destination.name),
              onChanged: (bool armed) =>
                  onChanged(destination.name, armed: armed),
            ),
            if (destination != destinations.last) const SizedBox(height: 9),
          ],
        ],
      ),
    );
  }
}

class TransportPanel extends StatelessWidget {
  const TransportPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Wrap(
        spacing: 28,
        runSpacing: 18,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          const _Metric(
            label: 'RUNTIME',
            value: 'Flutter 3 · Dart 3',
            color: _cyan,
          ),
          const _Metric(label: 'SESSION', value: 'Local preview'),
          const _Metric(label: 'TRANSPORT', value: 'Awaiting platform grant'),
          FilledButton.icon(
            onPressed: null,
            icon: const Icon(Icons.podcasts),
            label: const Text('Go live'),
          ),
        ],
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.construction_rounded, size: 40, color: _cyan),
          const SizedBox(height: 12),
          Text('$label is the next independent product slice'),
        ],
      ),
    );
  }
}

class BroadcastDestination {
  const BroadcastDestination(this.name, this.protocol, this.color);

  final String name;
  final String protocol;
  final Color color;
}

class _DestinationRow extends StatelessWidget {
  const _DestinationRow({
    required this.destination,
    required this.armed,
    required this.onChanged,
  });

  final BroadcastDestination destination;
  final bool armed;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _raisedSurface,
        border: Border.all(color: armed ? destination.color : _border),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 7, 7, 7),
        child: Row(
          children: <Widget>[
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: destination.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    destination.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    destination.protocol,
                    style: const TextStyle(
                      color: Color(0xFF9BA7B4),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Switch.adaptive(value: armed, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _surface,
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(padding: const EdgeInsets.all(18), child: child),
    );
  }
}

class _IdentityChip extends StatelessWidget {
  const _IdentityChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF172113),
        border: Border.all(color: const Color(0xFF395521)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Text(
        '@anticaptrad',
        style: TextStyle(color: _acid, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF9BA7B4),
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.45)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value, this.color});

  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionLabel(label),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
