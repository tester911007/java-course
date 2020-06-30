package edu.javacourse.studentorder.domain.register;

public class CityRegisterResponse
{
    private boolean registered;
    private boolean temporal;

    public boolean isExisting() {
        return registered;
    }

    public void setExisting(boolean registered) {
        this.registered = registered;
    }

    public boolean isTemporal() {
        return temporal;
    }

    public void setTemporal(Boolean temporal) {
        this.temporal = temporal;
    }

    @Override
    public String toString() {
        return "CityRegisterResponse{" +
                "existing=" + registered +
                ", temporal=" + temporal +
                '}';
    }
}
