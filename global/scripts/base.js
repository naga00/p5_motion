jQuery(function($){

	$(window).bind('resize', resizeHandler);
		
	function resizeHandler() {
		try{
			var processingInstance = Processing.getInstanceById('canvas');
			if(processingInstance != undefined && processingInstance.resize != undefined) processingInstance.resize();	
		}catch(error){}
	}
});
