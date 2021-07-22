$(function() {
    "use strict";
    $('.year-calendar').pignoseCalendar({
        theme: 'blue', // light, dark, blue
    });

    let calendarEvents =[
        {
           name: "meeting",
           date: "2021-06-20"
        },
        {
           name: "meeting",
           date: "2021-06-10"
        },
        {
            name: "meeting",
            date: "2021-06-25"
         },
         {
            name: "meeting",
            date: "2021-06-12"
         },
         {
            name: "meeting",
            date: "2021-06-15"
         },
         {
            name: "meeting",
            date: "2021-06-17"
         },
         {
            name: "meeting",
            date: "2021-06-28"
         },
         {
            name: "meeting",
            date: "2021-06-19"
         },{
            name: "meeting",
            date: "2021-06-1"
         },
         {
            name: "meeting",
            date: "2021-06-5"
         },
     ]

    $('.year-calendar').pignoseCalendar({
        scheduleOptions: {
            colors: {
                meeting: '#009098'
            }
        },
        schedules: calendarEvents});

    $('input.calendar').pignoseCalendar({
        format: 'YYYY-MM-DD' // date format string. (2017-02-02)
    });
});

