package com.kurlic.labyrinthserver;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class StatisticController {
    int amountOfLaunches = 0;

    public int getAmountOfLaunches()
    {
        return amountOfLaunches;
    }

    public void setAmountOfLaunches(int amountOfLaunches)
    {
        this.amountOfLaunches = amountOfLaunches;
    }

    @GetMapping("/launch/new")
    public int launch(@RequestParam(value = "name", defaultValue = "NONAME") String name)
    {
        setAmountOfLaunches(getAmountOfLaunches() + 1);
        System.out.println("New launch: " + name);
        return getAmountOfLaunches();
    }
    @GetMapping("/launch/get")
    public int getCLaunch()
    {

        System.out.println("Amount of launches: " + getAmountOfLaunches());
        return getAmountOfLaunches();
    }


}

