add-type -AssemblyName System.Windows.Forms 
$signature=@' 
  [DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)] 
  public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo); 
'@ 
$SendMouseEvent = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru 
$MOUSEEVENTF_MOVE = 0x00000001 
while ($true) { 
  $x = [System.Windows.Forms.Cursor]::Position.X 
  $y = [System.Windows.Forms.Cursor]::Position.Y 
  $SendMouseEvent::mouse_event($MOUSEEVENTF_MOVE, -1, 0, 0, 0) 
  $SendMouseEvent::mouse_event($MOUSEEVENTF_MOVE, 1, 0, 0, 0) 
  $rndPosX = $(Get-Random -Maximum 2 -Minimum -1) 
  $rndPosY = $(Get-Random -Maximum 2 -Minimum -1) 
  $x += $rndPosX 
  $y += $rndPosY 
  [System.Windows.Forms.Cursor]::Position = new-object System.Drawing.Point($x, $y) 
  $x = [System.Windows.Forms.Cursor]::Position.X 
  $y = [System.Windows.Forms.Cursor]::Position.Y 
} 
