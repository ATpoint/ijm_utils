// Shuffle an array, modified from https://imagej.net/ij/macros/examples/RandomizeArray.txt
function shuffleArray(array) {
   n = array.length;        // The number of items left to shuffle (loop invariant).
   while (n > 1) {
      k = n * random();     // 0 <= k < n.
      n--;                  // n is now the last pertinent index;
      temp = array[n];      // swap array[n] with array[k] (does nothing if k==n).
      array[n] = array[k];
      array[k] = temp;
   }
}

// Randomize whole numbers from 0 to size-1. Example Array.print(createRandomIndex(10)); 
// Depends on function "shuffleArray"
function createRandomIndex(size){

	x = Array.getSequence(size);
	shuffleArray(x);
	return x;
	
}

// Fresh start and constant settings, run this before doing any analysis
function startUp(){

  run("Fresh Start");
  run("ROI Manager...");
  roiManager("Show None");
  run("Input/Output...", "jpeg=85 gif=-1 file=.tsv use_file save_column");
  run("Set Measurements...", "area area_fraction limit display redirect=None decimal=2");

}

// This finds all folders in <dir> that start with <prefix> and end with <suffix>
function findFolders(dir, prefix, suffix){

  list_initial = getFileList(dir);
  list = newArray(0);
  
  for (i = 0; i < list_initial.length; i++) {

    is_prefix_ok = startsWith(list_initial[i], prefix);
    is_suffix_ok = endsWith(list_initial[i], suffix);
    is_directory_ok = File.isDirectory(dir + "/" + list_initial[i]);
  
    if(is_directory_ok && is_prefix_ok && is_suffix_ok){
      list = Array.concat(list, dir + "/" + list_initial[i]);        
    }
          
  }

  return list;

}
         
// Finds the index of a roi by its name in the roi manager. Returns -1 if not found
function findRoiWithName(roiName) { 
	nR = roiManager("Count"); 
 
	for (i=0; i<nR; i++) { 
		roiManager("Select", i); 
		rName = Roi.getName(); 
		if (matches(rName, roiName)) { 
			return i; 
		} 
	} 
	return -1; 
}

// Checks whether <array> contains <value> (perfect match, no regex), returns 1/0 if found or not
function arrayContains(array, value) {

  is_in = 0;
  for (i=0; i < array.length; i++){

    if(array[i] == value){
    	is_in = 1;
    }
    
  }
  
  return is_in;

}

// Empties ROImanager entirely
function clearRoiManager(){
  if(RoiManager.size > 0){
		  roiManager("Delete");
	}
}
