import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/domain/entities/country_entity.dart';
import 'package:hihear_mo/presentation/blocs/country/country_bloc.dart';

class CountrySelectionPage extends StatefulWidget {
  const CountrySelectionPage({super.key});

  @override
  State<CountrySelectionPage> createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {
  CountryEntity? _selectedCountry;

  @override
  void initState() {
    super.initState();
    context.read<CountryBloc>().add(const CountryEvent.loadCountries());
  }
  void _selectCountry(CountryEntity country) {
    setState(() {
      _selectedCountry = country;
    });
  }

  void _confirm() {
    if (_selectedCountry != null) {
      Navigator.pop(context, _selectedCountry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16213e),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildBody()),
            if (_selectedCountry != null) _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Text(
            "Chọn quốc gia",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildBody() {
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const Center(child: CircularProgressIndicator()),
          success: () => const SizedBox(),
          error: (msg) =>
              Center(child: Text(msg, style: const TextStyle(color: Colors.red))),
          data: (countries) => _buildCountryList(countries),
          filtered: (countries) => _buildCountryList(countries),
        );
      },
    );
  }

  Widget _buildCountryList(List<CountryEntity> countries) {
    if (countries.isEmpty) {
      return const Center(
        child: Text("Không tìm thấy", style: TextStyle(color: Colors.white)),
      );
    }

    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (_, i) => _buildCountryCard(countries[i]),
    );
  }

  Widget _buildCountryCard(CountryEntity country) {
    final isSelected = _selectedCountry?.code == country.code;

    return GestureDetector(
      onTap: () => _selectCountry(country),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.white30,
          ),
        ),
        child: Row(
          children: [
            Text(country.flag, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                country.name,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check, color: Colors.white)
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: _confirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Xác nhận", style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
