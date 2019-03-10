package computer.android.alertdialog;

import android.content.DialogInterface;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppComptActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Widget;

public class locationSetting{
  public static boolean enabledGps = false;  
  public static boolean enabledNetwork = false;
  
  protected LocationManager manageLocation;
    
    
  public void setting{
      
          LocationManager manage = (LocationManager)context.getSystemService(Context.LOCATION_SERVICE);
         
          AlertDialog.Builder alert = new AlertDialog.Builder(this);
          
          
      try{
        
          enableGps = manage.isProviderEnabled(LocationManager.GPS_PROVIDER);
          enabledNetwork = manage.isProviderEnabled(LocationManager.NETWORK_PROVIDER);
  
          
      if(!enableGps && !enabledNetwork) {
          
            alert.getTitle("System Unvailable");
          
            alert.setMessage(R.string.gps_network_not_enabled)
            
            alert.setPositiveButton(R.string.ok, 
            DialogInterface.OnClickListener listener)
                
            alert.setNegativeButton(R.string.cancel, 
            DialogInterface.OnClickListener listener)
           
            alert.show();
//error
          
            }
       if(!enableGps) {
           
           alert.getTitle("Location Unvailable");
           
           alert.setMessage("Cannot verify the location.")
            
            alert.setPositiveButton(R.string.ok, 
            DialogInterface.OnClickListener listener)
                
            alert.setNegativeButton(R.string.cancel, 
            DialogInterface.OnClickListener listener)
           
            alert.show();
           
//cannot verify current location
       }
       if(!enableNetwork) {
           
           alert.getTitle("Network Unvailable");
           
           alert.setMessage("Cannot verify the network.")
            
            alert.setPositiveButton(R.string.ok, 
            DialogInterface.OnClickListener listener)
                
            alert.setNegativeButton(R.string.cancel, 
            DialogInterface.OnClickListener listener)
           
            alert.show();
//cannot verify network
       }
       else{
           return true;

//works normally              
       }
   } catch(Exception ex) {
           e.printStackTrace();
           return false;
       }
}