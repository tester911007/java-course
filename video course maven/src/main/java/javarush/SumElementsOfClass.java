package javarush;

import java.util.Arrays;
import java.util.stream.DoubleStream;
import java.util.stream.IntStream;

public class SumElementsOfClass {
    public static void main(String[] args) {

        LimitedArray<Double> array = new LimitedArray<>(400);
        array.add(1.7);
        array.add(1.9);
        System.out.println(array);

        array.add(1.6);
        System.out.println(array);

        int[] myArray = {3, 5, 7, 12};
        int total = IntStream.of(myArray).sum();
        IntStream t = Arrays.stream(myArray);
        int tt = t.sum();
        System.out.println(tt);
    }
}
