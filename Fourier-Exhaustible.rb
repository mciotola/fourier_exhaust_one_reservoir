# Simulation Banner
puts "\n\n"
puts "###############################################################################"
puts "#                                                                             #"
puts "# FOURIER HEAT CONDUCTION LAW--EXHAUSTIBLE RESERVOIRS  version 01.06          #"
puts "#_____________________________________________________________________________#"
puts "#                                                                             #"
puts "# Copyright 2011-14 by Mark Ciotola; available for use under GNU license      #"
puts "# Last revised on 15 June 2014                                                #"
puts "# Website: http://www.heatsuite.com                                           #"
puts "# Source site: https://github.com/mciotola/fouriers_law_of_heat_conduction    #"
puts "#_____________________________________________________________________________#"
puts "#                                                                             #"
puts "# Description:                                                                #"
puts "# This simulation calculates the flow of heat energy across a thermal         #"
puts "# conductor that connects a warmer object to a cooler object.                 #"
puts "#                                                                             #"
puts "###############################################################################"
puts "\n\n"

      ###############################################################################
      #                                                                             #
      # Developed with Ruby 1.9.2                                                   #
      # Takes the following parameters: temperature of reservoirs                   #
      #                                 conductor material                          #
      #                                 conductor area                              #
	  #                                 conductor length                            #
      #                                                                             #
      ###############################################################################


puts "================================== Background =================================\n\n"
  
  puts " Fourier's Law of Conduction describes the flow of heat     "
  puts " energy through a material across a temperature difference. "
  puts "\n"
  puts " dQ/dt = (k A ) (d T / d L) \n"  
  puts " k = thermal conductivity of material \n"  
  puts "\n\n"
  
# Include the Math library
  include Math  
  
  
# Choose simulation parameters

  # Add a decimal point to tell Ruby to do floating point calculations

  warmertemp = 500.0 # in K
  coolertemp = 300.0 # in K
  material = 'copper' #'iron' 'wood'
  area = 1.0
  length = 20.0

  hotreservoirvolume = 100.0 # m^2
  coldreservoirvolume = 100.0 # m^2

  hotreservoirspecificheat = 1.0 # J/K?
  coldreservoirspecificheat = 1.0 #

  hotreservoirsenergy = 100000.0 # J
  coldreservoirsenergy =  70000.0 # J



# Look-up material thermal conductivity

  if material == 'iron'
	  thermalconductivity = 80.0
      elsif material == 'copper'
      thermalconductivity = 400.0
      elsif material == 'wood'
      thermalconductivity = 0.08
  end


# Initialize simulation variables

  time = 0 # s; this is an integer variable
  cumenergyflow = 0.0
  cumentropychange = 0.0

  hottemp = hotreservoirsenergy / (hotreservoirvolume * hotreservoirspecificheat)
  coldtemp = coldreservoirsenergy / (coldreservoirvolume * coldreservoirspecificheat)

  entropyhot = hotreservoirsenergy/hottemp
  entropycold = coldreservoirsenergy/coldtemp

  tempdiff = warmertemp - coolertemp
  heatenergyflow = ( (area * thermalconductivity) / length) * tempdiff

# Display the parameters

  puts "================================== Parameters =================================\n\n"

  puts sprintf "  Hot temp (in K): \t\t %7.3f " , hottemp.to_s
  puts sprintf "  Cold temp (in K): \t\t %7.3f " , coldtemp.to_s

  puts sprintf "  Warmer temp (in K): \t\t %7.3f " , warmertemp.to_s
  puts sprintf "  Cooler temp (in K): \t\t %7.3f " , coolertemp.to_s
  puts sprintf "  Thermal conductivity: \t %7.3f %s" , thermalconductivity.to_s, " in Watts/meter/Kelvin"
  puts sprintf "  Area (in m^2): \t\t %7.3f " , area.to_s
  puts sprintf "  Length (in m): \t\t %7.3f " , length.to_s
  puts sprintf "  Material: \t\t\t %7s " , material
  puts "\n\n"  

# Run the simulation




  puts "\n\n"
  puts "RESULTS: \n\n"

  puts "TIME \tT hot \tT cold\tDiff  \tE Flow \tCumlFlow\tS hot \tS cold \tS hot f\tS cold f\tS Chng\tS Cum Chng"
  puts "-----\t------\t------\t------\t-------\t--------\t------\t-------\t-------\t--------\t-------\t----------\n"


   while time < 11
      
        if coolertemp < warmertemp
            
  tempdiff = hottemp - coldtemp
  heatenergyflow = ( (area * thermalconductivity) / length) * tempdiff

  cumenergyflow = cumenergyflow + heatenergyflow

  hotreservoirsenergy = hotreservoirsenergy - heatenergyflow
  coldreservoirsenergy = coldreservoirsenergy + heatenergyflow
  
  hottemp = hotreservoirsenergy / (hotreservoirvolume * hotreservoirspecificheat)
  coldtemp = coldreservoirsenergy / (coldreservoirvolume * coldreservoirspecificheat)
  
  entropyhot = hotreservoirsenergy/hottemp
  entropycold = coldreservoirsenergy/coldtemp
  
  entropyflowhot = - heatenergyflow/hottemp
  entropyflowcold = heatenergyflow/coldtemp
  
  entropychange = entropyflowhot + entropyflowcold
  
  cumentropychange = cumentropychange + entropychange

# Display variable short names

t = time
hott = hottemp
coldt = coldtemp
tdiff = tempdiff
hef = heatenergyflow
cumef = cumenergyflow
shot = entropyhot
scold = entropycold
sfhot = entropyflowhot
sfcold = entropyflowcold
sc = entropychange
cumsc = cumentropychange

# Display the output

mystring = ("%3d\t%6.2f\t%6.2f\t%6.2f\t%7.2f\t%8.2f\t%6.2f\t%6.2f\t%7.2f\t%8.2f\t%7.2f\t%10.2f")
puts sprintf mystring, t.to_s, hott.to_s, coldt.to_s, tdiff.to_s, hef.to_s, cumef.to_s, shot.to_s, scold.to_s, sfhot.to_s, sfcold.to_s, sc.to_s, cumsc.to_s

   time = time + 1
    
end

end


puts "\n\n"



  puts "\n\n"

  puts "================================== Units Key ==================================\n\n"
  puts "  Abbreviation: \t\t Unit:"
  puts "\n"
  puts "       J \t\t\t Joules, a unit of energy"
  puts "       K \t\t\t Kelvin, a unit of temperature"
  puts "       m \t\t\t meters, a unit of length"
  puts "       s \t\t\t seconds, a unit of time"
  puts "\n\n"


  puts "================================== References =================================\n\n"
  puts "Daniel V. Schroeder, 2000, \"An Introduction to Thermal Physics.\""
  puts "\n\n"

# Future Question: what is the relation between entropy change and work performed?

# Table of thermal conductivities (Watts/meter/Kelvin)

  # Material	Thermal Conductivity
  # air				  0.026
  # wood			  0.08
  # water			  0.6
  # iron			 80
  # copper			400