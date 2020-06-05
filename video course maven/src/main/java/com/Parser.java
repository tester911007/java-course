package com;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Collection;
import java.util.HashMap;
import java.util.Scanner;

public class Parser {
    public static final String NOT_PARAM = "???";

    public static void main(String[] args) {
        try {
            URL url = new URL(getUrlFromConsole());
            HashMap<String, String> nameValue = getMapElements(url.getQuery());
            showNameElements(nameValue);

        } catch (MalformedURLException e) {
            System.out.println("Ну фигняяяя");
        }
    }

    private static String getUrlFromConsole() {
//      http://javarush.ru/alpha/index.html?obj=3.14&name=Amigo
//      http://javarush.ru/alpha/index.html?lvl=15&view&name=Amigo
        System.out.println("Enter your url: ");
        Scanner in = new Scanner(System.in);
        return in.nextLine();
    }

    private static HashMap<String, String> getMapElements(String url) {
        String[] pair;
        HashMap<String, String> nameValue = new HashMap<>();

        for (String s : url.split("&")) {
            pair = s.split("=");

            if (pair.length == 1) {
                pair = new String[]{pair[0], NOT_PARAM };
            }

            nameValue.put(pair[0], pair[1]);
        }

        return nameValue;
    }

    private static void showNameElements(HashMap<String, String> nameValue) {
        for (String name : nameValue.keySet()) {
            System.out.print(name + " ");
        }

        if (nameValue.containsKey("obj")) {
            System.out.println();
            showValueElements(nameValue.values());
        }
    }

    private static void showValueElements(Collection<String> values) {
        for (String value : values) {
            try {
                alert(Double.valueOf(value));

            } catch (Exception ex) {
                if (!value.equals(NOT_PARAM )) {
                    alert(value);
                }
            }
        }
    }

    public static void alert(double value) {
        System.out.println("double: " + value);
    }

    public static void alert(String value) {
        System.out.println("String: " + value);
    }
}
