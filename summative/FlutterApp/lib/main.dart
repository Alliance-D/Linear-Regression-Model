import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


const String apiUrl = 'https://linear-regression-model-38av.onrender.com/predict';

void main() {
  runApp(CO2EmissionApp());
}

class CO2EmissionApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CO₂ Emission Predictor',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/predictor': (context) => CO2EmissionPredictor(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              Colors.green.shade100,
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                
                // App Logo/Icon
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.eco,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                
                SizedBox(height: 32),
                
                // App Title
                Text(
                  'CO₂ Emission\nPredictor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 16),
                
                // made by me text
                Text(
                  'Advanced AI-powered carbon footprint analysis',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                
                SizedBox(height: 60),
                
                // Feature Cards
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildFeatureCard(
                          context,
                          Icons.analytics,
                          'Accurate Predictions',
                          'Get precise CO₂ emission forecasts using machine learning algorithms trained on comprehensive environmental data.',
                        ),
                        
                        SizedBox(height: 16),
                        
                        _buildFeatureCard(
                          context,
                          Icons.speed,
                          'Real-time Analysis',
                          'Input your data and receive instant predictions with detailed breakdowns of emission sources.',
                        ),
                        
                        SizedBox(height: 16),
                        
                        _buildFeatureCard(
                          context,
                          Icons.eco,
                          'Environmental Impact',
                          'Understand the environmental implications of different factors and make informed decisions.',
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 32),
                
                // Get Started Button
                Container(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/predictor');
                    },
                    icon: Icon(Icons.arrow_forward, size: 24),
                    label: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      elevation: 8,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Version/Credits
                Text(
                  'Made by Dushime Alliance \n ALU',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildFeatureCard(BuildContext context, IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CO2EmissionPredictor extends StatefulWidget {
  @override
  _CO2EmissionPredictorState createState() => _CO2EmissionPredictorState();
}

class _CO2EmissionPredictorState extends State<CO2EmissionPredictor>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TabController? _tabController;

  // Controllers organized by category
  final TextEditingController yearController = TextEditingController();
  final TextEditingController populationController = TextEditingController();
  final TextEditingController gdpPerCapitaController = TextEditingController();
  final TextEditingController gdpPerCapitaPPPController = TextEditingController();

  final TextEditingController transportationController = TextEditingController();
  final TextEditingController otherFuelCombustionController = TextEditingController();
  final TextEditingController manufacturingConstructionController = TextEditingController();
  final TextEditingController landUseChangeController = TextEditingController();
  final TextEditingController industrialProcessesController = TextEditingController();
  final TextEditingController fugitiveEmissionsController = TextEditingController();
  final TextEditingController energyController = TextEditingController();
  final TextEditingController electricityHeatController = TextEditingController();
  final TextEditingController bunkerFuelsController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();

  String result = '';
  bool isLoading = false;
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    yearController.dispose();
    populationController.dispose();
    gdpPerCapitaController.dispose();
    gdpPerCapitaPPPController.dispose();
    transportationController.dispose();
    otherFuelCombustionController.dispose();
    manufacturingConstructionController.dispose();
    landUseChangeController.dispose();
    industrialProcessesController.dispose();
    fugitiveEmissionsController.dispose();
    energyController.dispose();
    electricityHeatController.dispose();
    bunkerFuelsController.dispose();
    buildingController.dispose();
    super.dispose();
  }

  Future<void> predictCO2Emission() async {
    setState(() {
      result = '';
      isLoading = true;
      showResult = false;
    });

    final Map<String, dynamic> inputData = {
      "Year": int.tryParse(yearController.text) ?? 0,
      "Population": int.tryParse(populationController.text) ?? 0,
      "GDP_PER_CAPITA_USD": double.tryParse(gdpPerCapitaController.text) ?? 0.0,
      "GDP_PER_CAPITA_PPP_USD": double.tryParse(gdpPerCapitaPPPController.text) ?? 0.0,
      "Transportation_Mt": double.tryParse(transportationController.text) ?? 0.0,
      "Other_Fuel_Combustion_Mt": double.tryParse(otherFuelCombustionController.text) ?? 0.0,
      "Manufacturing_Construction_Mt": double.tryParse(manufacturingConstructionController.text) ?? 0.0,
      "Land_Use_Change_and_Forestry_Mt": double.tryParse(landUseChangeController.text) ?? 0.0,
      "Industrial_Processes_Mt": double.tryParse(industrialProcessesController.text) ?? 0.0,
      "Fugitive_Emissions_Mt": double.tryParse(fugitiveEmissionsController.text) ?? 0.0,
      "Energy_Mt": double.tryParse(energyController.text) ?? 0.0,
      "Electricity_Heat_Mt": double.tryParse(electricityHeatController.text) ?? 0.0,
      "Bunker_Fuels_Mt": double.tryParse(bunkerFuelsController.text) ?? 0.0,
      "Building_Mt": double.tryParse(buildingController.text) ?? 0.0,
    };

    if (inputData.values.any((val) => val == 0 || val == 0.0)) {
      setState(() {
        isLoading = false;
        result = "Please fill all fields with valid values.";
        showResult = true;
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(inputData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          isLoading = false;
          result = "${data['predicted_CO2_emission_Mt'].toStringAsFixed(2)} Mt";
          showResult = true;
        });
      } else {
        setState(() {
          isLoading = false;
          result = "API Error: ${response.body}";
          showResult = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        result = "Network Error: $e";
        showResult = true;
      });
    }
  }

  Widget buildTextField(String label, TextEditingController controller, 
      {bool isInt = false, IconData? icon, String? suffix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: !isInt),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: label,
          prefixIcon: icon != null ? Icon(icon, size: 20) : null,
          suffixText: suffix,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }
          if (isInt && int.tryParse(value) == null) {
            return 'Invalid integer';
          }
          if (!isInt && double.tryParse(value) == null) {
            return 'Invalid number';
          }
          return null;
        },
      ),
    );
  }

  Widget buildSectionCard(String title, List<Widget> children, IconData icon) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text('CO₂ Emission Predictor',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Colors.black45,
                        ),
                      ],
                    )),
                titlePadding: EdgeInsets.only(left: 16, bottom: 80),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.eco,
                      size: 80,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
                controller: _tabController!,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(icon: Icon(Icons.info, color: Colors.white), text: 'Basic Info'),
                  Tab(icon: Icon(Icons.factory, color: Colors.white), text: 'Emissions'),
                  Tab(icon: Icon(Icons.analytics, color: Colors.white), text: 'Results'),
                ],
              ),
            ),
          ];
        },
        body: Form(
          key: _formKey,
          child: TabBarView(
            controller: _tabController!,
            children: [
              // Basic Information Tab
              SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildSectionCard(
                      'General Information',
                      [
                        buildTextField("Year", yearController, 
                            isInt: true, icon: Icons.calendar_today),
                        buildTextField("Population", populationController, 
                            isInt: true, icon: Icons.people),
                        buildTextField("GDP Per Capita", gdpPerCapitaController, 
                            icon: Icons.attach_money, suffix: "USD"),
                        buildTextField("GDP Per Capita PPP", gdpPerCapitaPPPController, 
                            icon: Icons.monetization_on, suffix: "USD"),
                      ],
                      Icons.info,
                    ),
                  ],
                ),
              ),
              
              // Emissions Data Tab
              SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildSectionCard(
                      'Transportation & Energy',
                      [
                        buildTextField("Transportation", transportationController, 
                            icon: Icons.directions_car, suffix: "Mt"),
                        buildTextField("Energy", energyController, 
                            icon: Icons.bolt, suffix: "Mt"),
                        buildTextField("Electricity/Heat", electricityHeatController, 
                            icon: Icons.power, suffix: "Mt"),
                        buildTextField("Other Fuel Combustion", otherFuelCombustionController, 
                            icon: Icons.local_fire_department, suffix: "Mt"),
                      ],
                      Icons.directions_car,
                    ),
                    
                    buildSectionCard(
                      'Industrial & Construction',
                      [
                        buildTextField("Manufacturing/Construction", manufacturingConstructionController, 
                            icon: Icons.construction, suffix: "Mt"),
                        buildTextField("Industrial Processes", industrialProcessesController, 
                            icon: Icons.precision_manufacturing, suffix: "Mt"),
                        buildTextField("Building", buildingController, 
                            icon: Icons.apartment, suffix: "Mt"),
                      ],
                      Icons.factory,
                    ),
                    
                    buildSectionCard(
                      'Environmental & Other',
                      [
                        buildTextField("Land-Use Change & Forestry", landUseChangeController, 
                            icon: Icons.forest, suffix: "Mt"),
                        buildTextField("Fugitive Emissions", fugitiveEmissionsController, 
                            icon: Icons.cloud, suffix: "Mt"),
                        buildTextField("Bunker Fuels", bunkerFuelsController, 
                            icon: Icons.local_shipping, suffix: "Mt"),
                      ],
                      Icons.nature,
                    ),
                  ],
                ),
              ),
              
              // Results Tab
              SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Icon(
                              Icons.analytics,
                              size: 64,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Prediction Results',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 24),
                            
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton.icon(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          predictCO2Emission();
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Please fill all required fields'),
                                              backgroundColor: Colors.orange,
                                            ),
                                          );
                                        }
                                      },
                                icon: isLoading
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Icon(Icons.calculate),
                                label: Text(
                                  isLoading ? 'Predicting...' : 'Predict CO₂ Emission',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            
                            if (showResult) ...[
                              SizedBox(height: 24),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: result.contains('Error') 
                                      ? Colors.red.withOpacity(0.1)
                                      : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: result.contains('Error')
                                        ? Colors.red
                                        : Theme.of(context).colorScheme.primary,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      result.contains('Error') ? Icons.error : Icons.eco,
                                      size: 48,
                                      color: result.contains('Error')
                                          ? Colors.red
                                          : Theme.of(context).colorScheme.primary,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      result.contains('Error') ? 'Error' : 'Predicted CO₂ Emission',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      result,
                                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: result.contains('Error')
                                            ? Colors.red
                                            : Theme.of(context).colorScheme.primary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info_outline, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'How to use',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              '1. Fill in the basic information in the first tab\n'
                              '2. Enter emission data in the second tab\n'
                              '3. Come to this tab and click "Predict" to get results\n'
                              '4. All values are measured in megatons (Mt) except for basic info',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}