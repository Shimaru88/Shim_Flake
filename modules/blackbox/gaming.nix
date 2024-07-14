{ pkgs, ... }

{
	programs.steam.enable = true;
	
	environment.systemPackages = with pkgs; [
		#Steam
		mangohud
		gamemode

		#Wine
		wine
		winetricks
		protontricks
		vulkan-tools

		#Extra dependencies		
}
