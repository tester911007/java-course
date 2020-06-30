package edu.javacourse.city.web;

import edu.javacourse.city.dao.PersonCheckDao;
import edu.javacourse.city.dao.PoolConnectionBuilder;
import edu.javacourse.city.domain.PersonRequest;
import edu.javacourse.city.domain.PersonResponse;
import edu.javacourse.city.exception.PersonCheckException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;
import javax.inject.Singleton;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/check")
@Singleton
public class CheckPersonService {

    private static final Logger logger = LoggerFactory.getLogger(CheckPersonService.class);

    private PersonCheckDao dao;

    @PostConstruct
    public void init() {
        logger.info("SERVLET is created");
        dao = new PersonCheckDao();
        dao.setConnectionBuilder(new PoolConnectionBuilder());
    }

//    @PreDestroy
//    public void destroy() {
//        logger.info("FINISH");
//    }

    //    @GET
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
//    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
//    public PersonResponse checkPerson(@PathParam("id") int simpleId,
//                                      @QueryParam("name") String simpleName) {
//        return new PersonResponse();
//    }
    public PersonResponse checkPerson(PersonRequest request) throws PersonCheckException {
        logger.info(request.toString());
        return dao.checkPerson(request);
//        return new PersonResponse();
    }
}

//GET /city-register-1.0/rest/check/101?name=value