import 'package:flutter/material.dart';
import 'package:myport4lio/core/constants/app_constants.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  TimelineScreenState createState() => TimelineScreenState();
}

class TimelineScreenState extends State<TimelineScreen> {
  final ScrollController _scrollController = ScrollController();
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _progress = _scrollController.offset /
            _scrollController.position.maxScrollExtent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        // appBar: AppBar(
        //   title: Text("Experience & Education Timeline"),
        // ),
        // body:
        // Stack(children: [
        // SingleChildScrollView(
      // child:
      ListView(
        controller: _scrollController,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        children: [
          _buildSectionHeader(AppConstants.experience),
          Timeline.tileBuilder(
            builder: TimelineTileBuilder.connectedFromStyle(
              contentsAlign: ContentsAlign.alternating,
              oppositeContentsBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('opposite\ncontents'),
              ),
              contentsBuilder: (context, index) => _buildTimelineItem(
                title: "Frontend Intern @Brain Crowd Software Private Limited",
                duration: "Nov 2022 - Aug 2023",
                location: "Bengaluru, Karnataka",
                description:
                    "Enhanced user interface and interactivity for Boxxport by developing dynamic static pages using HTML, CSS, Typescript, and AngularJS. Collaborated with backend teams, integrated APIs, and ensured optimal performance through manual testing.",
              ),
              itemExtent: .5,
              connectorStyleBuilder: (context, index) =>
                  ConnectorStyle.solidLine,
              indicatorStyleBuilder: (context, index) =>
                  IndicatorStyle.outlined,
              itemCount: 3,
            ),
          ),
          _buildSectionHeader(AppConstants.education),
          // _buildTimeline(title),
        ],
      // ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildTimeline(String title, duration, location, description) {
    return Timeline.tileBuilder(
      builder: TimelineTileBuilder.connectedFromStyle(
        contentsAlign: ContentsAlign.alternating,
        oppositeContentsBuilder: (context, index) => const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('opposite\ncontents'),
        ),
        contentsBuilder: (context, index) => _buildTimelineItem(
          title: title,
          duration: duration,
          location: location,
          description: description,
        ),
        connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
        indicatorStyleBuilder: (context, index) => IndicatorStyle.outlined,
        itemCount: 3,
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String duration,
    required String location,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 12, color: Colors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(duration,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(location,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimelinePainter extends CustomPainter {
  final double progress;

  TimelinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final height = size.height * progress;

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
