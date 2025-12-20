import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FundiMyJobsPage extends StatefulWidget {
  const FundiMyJobsPage({super.key});

  @override
  _FundiMyJobsPageState createState() => _FundiMyJobsPageState();
}

class _FundiMyJobsPageState extends State<FundiMyJobsPage> {
  int _selectedTabIndex = 0;
  double avgRating = 4.5;
  int complete = 2;
  int active = 5;
  bool _isLoading = true;
  List<Map<String, dynamic>> _allJobs = [];

  @override
  void initState() {
    super.initState();
    _fetchAllJobs();
  }
  
  // Fetch all jobs with all statuses
  Future<void> _fetchAllJobs() async {
    try {
      final response = await http.get(
        Uri.parse('https://bingwa-fix-backend.vercel.app/api/requests/available'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _allJobs = List<Map<String, dynamic>>.from(data);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error: $e'),
          )
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Management', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Track and manage your accepted jobs',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
              ),
            ),

            // Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildStatCard('Active Jobs', active.toString()),
                  const SizedBox(width: 10),
                  _buildStatCard('Completed', complete.toString()),
                  const SizedBox(width: 10),
                  _buildStatCard('Avg Rating', avgRating.toString()),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Filter Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => setState(() => _selectedTabIndex = 0),
                      style: TextButton.styleFrom(
                        backgroundColor: _selectedTabIndex == 0
                            ? Colors.blue[100]
                            : Colors.grey[200],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                      ),
                      child: Text(
                        'All Jobs',
                        style: TextStyle(
                          color: _selectedTabIndex == 0
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => setState(() => _selectedTabIndex = 1),
                      style: TextButton.styleFrom(
                        backgroundColor: _selectedTabIndex == 1
                            ? Colors.blue[100]
                            : Colors.grey[200],
                      ),
                      child: Text(
                        'Active',
                        style: TextStyle(
                          color: _selectedTabIndex == 1
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => setState(() => _selectedTabIndex = 2),
                      style: TextButton.styleFrom(
                        backgroundColor: _selectedTabIndex == 2
                            ? Colors.blue[100]
                            : Colors.grey[200],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                      ),
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          color: _selectedTabIndex == 2
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Empty State
            SizedBox(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _isLoading ?
                    const CircularProgressIndicator(color: Colors.blueGrey,)
                        : _allJobs.isEmpty ?
                    Padding(padding: EdgeInsets.all( 8.0),
                      child: Column(
                        children: [
                          const Icon(Icons.work_outline, size: 50, color: Colors.grey),
                          const SizedBox(height: 16),
                          const Text(
                            'No jobs found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No ${_selectedTabIndex == 1 ? 'active' : 'completed'} jobs at the moment.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                        :ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _allJobs.length,
                        itemBuilder: (context, index) {
                          final job = _allJobs[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Text(job['category'] ?? 'Job'),
                              subtitle: Text(job['location'] ?? ''),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}