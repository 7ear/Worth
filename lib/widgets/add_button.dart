import '../imports.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(vertical: 15),
        backgroundColor: Color.fromARGB(248, 237, 237, 237),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
      onPressed: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAsset()));
      },
      child: Text('Add', style: GoogleFonts.roboto(textStyle: theme.textTheme.headlineMedium)),
    );
  }
}
