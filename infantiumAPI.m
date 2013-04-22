//
//  infantiumAPI.m
//  Chup ON
//
//  Created by Rubén García on 21/02/13.
//
//

#import "infantiumAPI.h"

@implementation infantiumAPI
@synthesize responseData, uriplayer, uriGame, codigoestado, salida, edad, uritutor, nickname, modo;

-(id) init
{
    self = [super init];
    if (self != nil)
    {
    //[uriGame retain];
        //myBoolIvar = YES;
        // The above is an implicit version of self->myBoolIvar = YES;
    }
    return self;
}

-(NSString*)convertoURI:(NSString*)cadenaurl{
    //Como en realidad tengo una URL tengo que convertirla en URI
    NSMutableString * uri = [NSMutableString stringWithString: cadenaurl];
    [uri deleteCharactersInRange: [uri rangeOfString: @"https://beta.infantium.com"]];
    //NSLog(@" %@", uri);
    return uri;
}



-(NSString *)get_contentapp_uuid
{
    NSError* error=nil;
    NSString* uuid=nil;
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@", @"https://beta.infantium.com/api/v1/contentapp/3/?api_username=ChupOn&api_key=2245a10f-bdb1-480d-869d-d1bcad7fbf0f"]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPBody:jsonData];
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSURLResponse *response;
    NSData *result =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
        //Respuesta
        //NSLog([NSString stringWithFormat:@"%d",[httpResponse statusCode]]);
        if([httpResponse statusCode]==200){
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:result
                                  options:kNilOptions
                                  error:&error];
            //uritutor = [json objectForKey:@"tutor"]; //2
            uuid=  [json objectForKey:@"contentapp_uuid"];
            //NSLog(@"Tutor: %@", tutor);
        }
    }
    return uuid;
}

-(NSString *)get_player_uuid
{
    NSError* error=nil;
    NSString* uuid=nil;
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", uriplayer, @"?api_username=ChupOn&api_key=2245a10f-bdb1-480d-869d-d1bcad7fbf0f"]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPBody:jsonData];
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSURLResponse *response;
    NSData *result =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
        //Respuesta
        //NSLog([NSString stringWithFormat:@"%d",[httpResponse statusCode]]);
        if([httpResponse statusCode]==200){
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:result
                                  options:kNilOptions
                                  error:&error];
            //uritutor = [json objectForKey:@"tutor"]; //2
            uuid=  [json objectForKey:@"player_uuid"];
            //NSLog(@"Tutor: %@", tutor);
        }
    }
    return uuid;
}

-(NSString *)get_gameplay_uuid
{
    NSError* error=nil;
    NSString* uuid=nil;
    [uriGame retain];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", uriGame, @"?api_username=ChupOn&api_key=2245a10f-bdb1-480d-869d-d1bcad7fbf0f"]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPBody:jsonData];
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    NSURLResponse *response;
    NSData *result =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
        //Respuesta
        //NSLog([NSString stringWithFormat:@"%d",[httpResponse statusCode]]);
        if([httpResponse statusCode]==200){
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:result
                                  options:kNilOptions
                                  error:&error];
            //uritutor = [json objectForKey:@"tutor"]; //2
            uuid=  [json objectForKey:@"gameplay_uuid"];
            //NSLog(@"Tutor: %@", tutor);
        }
    }
    return uuid;
}

-(void)getTutorFromPlayer:(NSString*)player
{
    // Recive la uri de un jugador y la guarda en las UserDefaults
    
    NSError* error=nil;
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", player, @"?api_username=ChupOn&api_key=2245a10f-bdb1-480d-869d-d1bcad7fbf0f"]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPBody:jsonData];
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
     
    NSURLResponse *response;
    NSData *result =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
    //Respuesta
        //NSLog([NSString stringWithFormat:@"%d",[httpResponse statusCode]]);
        if([httpResponse statusCode]==200){
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:result
                                  options:kNilOptions
                                  error:&error];
            uritutor = [json objectForKey:@"tutor"]; //2
            //gameplay_uuid = [json objectForKey:@"gameplay_uuid"];
            //NSLog(@"Tutor: %@", tutor);
        }
    }
}

- (NSError *)infantium_createGame
    {
    //Crea una instancia de juego obteniendo los datos de jugador de UserDefaults
    NSError* error=nil;
    //Obtenemos datos del jugador de UserDefaults
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults){
            uriplayer = [standardUserDefaults objectForKey:@"uriplayer"];
        }
        if (uriplayer!=nil)
        {
        //Como en realidad tengo una URL tengo que convertirla en URI
        NSString * uriplayerURI;
        uriplayerURI=[self convertoURI:uriplayer];
        NSLog(@"Recurso de jugador: %@", uriplayerURI);
        //Creamos la partida y obtenemos el id de la instancia de la partida
        modo=3; //Creación de Partida. Este modo es para controlar los métodos delegados
        //Creación de objeto JSON//////
        NSDictionary* info = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"/api/v1/contentapp/3/",
                                  @"contentapp",
                                  uriplayerURI,
                                  @"player",
                                    @"true",
                                    @"is_playing",
                                  nil];
            
            // object to data
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&error];
            //NSLog([[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);    ///////////////////////////////

            NSURL *myURL = [NSURL URLWithString:@"https://beta.infantium.com/api/v1/gameplay/?api_username=ChupOn&api_key=2245a10f-bdb1-480d-869d-d1bcad7fbf0f"];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
            //[request setHTTPBody:[jsonData dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:jsonData];
            [[NSURLConnection alloc] initWithRequest:request delegate:self]; //Llamada asÌncrona.
            //Lanzo la llamada asíncrona
            //El modo para la creación del juego es 3
        }
        else NSLog(@"Error, no se han encontrado los datos del jugador. La instancia de juego no se ha creado");
        return error;
}


-(NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileLocation{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:[fileLocation pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

- (NSError *)infantium_sendData:(NSDictionary*)info
{
    NSError* error=nil;
    [uriGame retain];
     modo=5; //Envío de datos. Este modo es para controlar los métodos delegados
    //Compruebo que la partida existe
    if (uriGame!=nil) {
        //NSLog(uriGame);
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&error];
        NSURL *myURL = [NSURL URLWithString:@"https://beta.infantium.com/api/v1/rawdata/?api_username=ChupOn&api_key=2245a10f-bdb1-480d-869d-d1bcad7fbf0f"];
        NSLog([[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
        //[request setHTTPBody:[jsonData dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:jsonData];
        [[NSURLConnection alloc] initWithRequest:request delegate:self]; //Llamada asincrona.
        //Lanzo la llamada asíncrona
        //El modo para envío de datos es 5

    }
    else NSLog(@"La partida no existe, no se pueden enviar datos");
    
    return error;
}


- (NSError *)infantium_destroyGame
    {
    //Destruye una instancia de juego obteniendo los datos de juego del objeto de UserDefaults
    NSError* error=nil;
    modo=4; //Borrado de partida. Este modo es para controlar los métodos delegados
        if(uriGame!=nil){//Compruebo que la partida existe y la borro
            //[uriGame release];
            //convert object to data
            NSURL *myURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", uriGame, @"finish/?api_username=ChupOn&api_key=2245a10f-bdb1-480d-869d-d1bcad7fbf0f"]];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
            //[request setHTTPBody:[jsonData dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            //[request setHTTPBody:jsonData];
            [[NSURLConnection alloc] initWithRequest:request delegate:self]; //Llamada asÌncrona.
            //Lanzo la llamada asíncrona
            //El modo para la destrucción del juego es 4
        }
        else{
            NSLog(@"La partida no existe, no se puede eliminar");
        }
    return error;
    }

- (NSError *)infantium_createPlayer //Creación de nuevo jugador sin tutor.
{
    // hay que saber si estamos creando el primer jugador. en esta caso hay que autogenerar el tutor
    //Verifico en UserDefaults user tutor está vacío. si es así es el primer jugador y tengo que buscar tb el tutor
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *userDefaultsUritutor = nil;
    NSError* error=nil;
    
    if (standardUserDefaults){
        userDefaultsUritutor = [standardUserDefaults objectForKey:@"uritutor"];
        //age=0; //pruebas
        if(userDefaultsUritutor==0)
        {
            // primera ejecución del programa. Intento crear el usuario.
            modo=1; //Creación de nuevo jugador sin Tutor. Este modo es para controlar los métodos delegados
            //Creación de objeto JSON//////
            NSDictionary* info = [NSDictionary dictionaryWithObjectsAndKeys:
                                  nickname,
                                  @"nickname",
                                  edad,
                                  @"months",
                                  nil];
            
            //object to data
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&error];
            //NSLog([[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);    ///////////////////////////////
            
            NSURL *myURL = [NSURL URLWithString:@"https://beta.infantium.com/api/v1/player/?api_username=ChupOn&api_key=2245a10f-bdb1-480d-869d-d1bcad7fbf0f"];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:2];
            //[request setHTTPBody:[jsonData dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:jsonData];
            [[NSURLConnection alloc] initWithRequest:request delegate:self]; //Llamada asÌncrona.
            //La llamada asíncrona delegará y el modo 1 lanzará un método para recuperar el tutor con una conexión síncrona.
        }
        else {
            // El usuario que creo tiene que tener el tutor asignado
            }
        }
    return error; // No significa que tenga éxito, simplemente que ha pasado bien los parámetros
    }

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc] init];
    //CÛdigo de estado
    //NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    //int responseStatusCode = [httpResponse statusCode];
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
        //If you need the response, you can use it here
        codigoestado=[httpResponse statusCode];
        
        NSLog(@"Código estado: %@",[NSString stringWithFormat:@"%d",codigoestado]);
        //toda la cabecera completa
       
        if(modo==1 || modo==2)
            {// si estoy creando un nuevo jugador con o sin tutor
            uriplayer=[[httpResponse allHeaderFields] objectForKey:@"location"];
            NSLog(@"Jugador creado en uri: %@", uriplayer);
            }
            else if(modo==3){ //Creación de partida
            uriGame=[[httpResponse allHeaderFields] objectForKey:@"location"];
            NSLog(@"Location response uri: %@", uriGame);
            }
            else if(modo==5){// Envío de datos
            //reservado para utilizar el uri de rawdata
            NSLog(@"Location response uri: %@", [[httpResponse allHeaderFields] objectForKey:@"location"]);
            }
        }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [responseData release];
    [connection release];
    NSLog(@"Error imposible obtener datos. Sin conexión a Internet");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"Exito! Recibidos%d bytes",[responseData length]);
    //Escritura en User Defaults
    
    if (modo==1){// lo que hago si estoy creando un nuevo jugador sin tutor. Solamente ocurrirá la primera vez.
        //Antes de escribir los datos, tengo que localizar la uri del tutor.
        // Para ello lanzaré
        [self getTutorFromPlayer:uriplayer];
        //NSLog(uritutor);
        if(uritutor !=nil && uriplayer !=nil && edad!=nil && nickname!=nil)
        {
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            if (standardUserDefaults) {
                [standardUserDefaults setObject:uriplayer forKey:@"uriplayer"];
                [standardUserDefaults setObject:edad forKey:@"months"];
                [standardUserDefaults setObject:nickname forKey:@"nickname"];
                [standardUserDefaults setObject:uritutor forKey:@"uritutor"];
                [standardUserDefaults synchronize];
                NSLog(@"Datos almacenados en UserDefaults");
            }
        }
        else NSLog(@"Error !! Faltan campos para poder generar el jugador");
    }
    else if (modo==3){
        NSLog(@"Pardida número: %@ creada",uriGame);
    }
    // Salida JSON
    //NSString *data=[[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    salida=[[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"Salida json: %@",salida);
}

- (void)dealloc
{
    [super dealloc];
}

@end
