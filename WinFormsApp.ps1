# To get code suggestions, you need to run `Add-Type -AssemblyName System.Windows.Forms` in the current PowerShell Extension session.
Add-Type -AssemblyName System.Windows.Forms

$form = [Windows.Forms.Form]::new()
$form.Text = "Demo GUI"
$form.Width = 400
$form.Height = 300
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

$button = [Windows.Forms.Button]::new()
$button.Text = "Click me!"
$button.Width = 100
$button.Height = 40
$button.Left = $form.ClientSize.Width / 2 - $button.Width / 2
$button.Top = $form.ClientSize.Height / 2 - $button.Height / 2

$button.Add_Click(
    {
        [System.Windows.Forms.MessageBox]::Show("Hello from PowerShell GUI!")
    }
)

$form.Controls.Add($button)
$form.ShowDialog()
