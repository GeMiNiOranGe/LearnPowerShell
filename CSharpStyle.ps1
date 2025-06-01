Add-Type -TypeDefinition @"
public class Program
{
    public static void Main()
    {
        System.Console.WriteLine("Hello world!!!");
    }
}
"@

[Program]::Main()
