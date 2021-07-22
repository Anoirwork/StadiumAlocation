$( function () {
	"use strict";


	// Extra chart
	Morris.Area( {
		element: 'extra-area-chart',
		data: [ {
				period: 'Monday',
				Match: 1,
				Event: 3,
        }, {
				period: 'Tuesday',
				Match: 5,
				Event: 2,
        }, {
				period: 'Wednesday',
				Match: 7,
				Event: 2,
        }, {
				period: 'Thursday',
				Match: 1,
				Event: 2,
        }, {
				period: 'Friday',
				Match: 8,
				Event: 1,
        }, {
				period: 'Saturday',
				Match: 7,
				Event: 12,
        }, {
				period: 'Sunday',
				Match: 1,
				Event: 2,
        }


        ],
		parseTime: false,
		lineColors: [ '#26DAD2', '#4680ff' ],
		xkey: 'period',
		ykeys: [ 'Match', 'Event' ],
		labels: [ 'Match', 'Event' ],
		pointSize: 0,
		lineWidth: 0,
		resize: true,
		fillOpacity: 0.8,
		hideHover: 'auto'

	} );



} );
