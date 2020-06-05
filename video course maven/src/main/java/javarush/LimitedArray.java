package javarush;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

public class LimitedArray<T> {

    private int limit;
    private List<T> elements = new ArrayList<T>();

    public LimitedArray(int limit) {
        this.limit = limit;
    }

    public int getLimit() {
        return limit;
    }

    public int size() {
        return elements.size();
    }

    public boolean isEmpty() {
        return elements.isEmpty();
    }

    public boolean contains(Object o) {
        return elements.contains(o);
    }

    public Iterator<T> iterator() {
        return elements.iterator();
    }

    public boolean add(T e) {
        checkLimit(elements.size() + 1);
        return elements.add(e);
    }

    public boolean remove(Object o) {
        return elements.remove(o);
    }

    public boolean addAll(Collection<? extends T> c) {
        checkLimit(c.size() + elements.size() + 1);
        return elements.addAll(c);
    }

    public boolean removeAll(Collection<?> c) {
        return elements.removeAll(c);
    }



    public void clear() {
        elements.clear();

    }


    private void checkLimit(int size) {
//        if(size > limit) {
//            throw new IndexOutOfBoundsException("Too many elements");
//        }
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (T element : elements) {
            sb.append(element).append(" ");
        }
        return sb.toString();
    }

}
