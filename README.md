infantiumIOS
============

Connect your IOS APPS With Infantium API (NO ARC)

Versión API alpha 0.1
//En fase experimental.

ficheros:
infantiumAPI.h
infantiumAPI.m

---------------------------------------
USANDO infantiumAPI
---------------------------------------

    #import "infantiumAPI.h"

Propiedades

    @property (nonatomic, retain)infantiumAPI *infantiumAPIHTTP;

1.Creación del jugador:


    //Verifico en UserDefaults que edad tiene el niño, si no está registrada le añado la edad
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *age = nil;
    NSString *uriplayer,*nickname, *uritutor;
    
    if (standardUserDefaults){
        age = [standardUserDefaults objectForKey:@"months"];
        uriplayer=[standardUserDefaults objectForKey:@"uriplayer"];
        nickname=[standardUserDefaults objectForKey:@"nickname"];
        uritutor=[standardUserDefaults objectForKey:@"uritutor"];
        //age=0; //pruebas
    if(age==0 |uriplayer==0 | nickname==0 | uritutor==0)
        //significa que el jugador no existe o no ha sido creado correctamente
    {
        //El jugador no exite, creamos un jugador y escribimos las variables user default
        //No importa si el jugador es nuevo
        NSInteger edadjugador = 18;
        NSString *nombrejugador= @"Juanin";
        // LLAMADA A LA API DE INFANTIUN CON CLASE ASÍNCRONA. EL OBJETO SE ENCARGARÁ DE DECIDIR QUE TIPO DE ALTA ES.
        // EN ESTE CASO TENDRÁ QUE BUSCAR EL TUTOR.
        infantiumAPIHTTP=[infantiumAPI alloc];
        infantiumAPIHTTP.nickname=nombrejugador;
        infantiumAPIHTTP.edad=[NSString stringWithFormat:@"%d", edadjugador];
        [infantiumAPIHTTP infantium_createPlayer];
        }
    else {
        //Significa que ya está dado de alta. Recupero su edad
        NSLog(@"Nombre Jugador: %@",nickname);
        NSLog(@"Edad Jugador: %@",age);
        NSLog(@"Uri Player: %@",uriplayer);
        NSLog(@"Uri Tutor: %@",uritutor);
    }

2.Creación del juego:

    infantiumAPIHTTP=[infantiumAPI alloc]; No es necesario si se hace todo en la misma pantalla.
    [infantiumAPIHTTP infantium_createGame];
  

3.Envío de datos a los servidores.

    // Recopilando uuid necesarios
    NSString *gameplay_uuid = [infantiumAPIHTTP get_gameplay_uuid];
    NSString *player_uuid= [infantiumAPIHTTP get_player_uuid];
    NSString *contentapp_uuid= [infantiumAPIHTTP get_contentapp_uuid];

Envío de datos siendo datos un NSDictionary

    [infantiumAPIHTTP infantium_sendData:datos];

4.Destrucción de la partida

    [infantiumAPIHTTP infantium_destroyGame];

5.Problemas encontrados
  -En determinadas ocasiones se obtiene un error desconocido al intentar enviar el Json de datos.
  -Actualmente el envío de datos Json no es asimétrico


6.Ejemplo de construcción de JSON


           NSArray* elements_array = [NSArray arrayWithObjects:
                                      [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"id",@"id",
                                       @"2D",@"type",
                                       @"{'w':0,'h':0,'d':0}",@"type",
                                       @"NOSHAPE",@"shape",
                                       @"0",@"xpos",
                                       @"0",@"ypos",
                                       @"0",@"zpos",
                                       nil],
                                      [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"id2",@"id",
                                       @"2D",@"type",
                                       @"{'w':0,'h':0,'d':0}",@"type",
                                       @"NOSHAPE",@"shape",
                                       @"0",@"xpos",
                                       @"0",@"ypos",
                                       @"0",@"zpos",
                                       nil],
                                      nil];
            
            NSArray* tapsNoObjects = [NSArray arrayWithObjects:
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"0",@"x_pos",
                               @"0",@"y_pos",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"0",@"x_pos",
                               @"0",@"y_pos",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"0",@"x_pos",
                               @"0",@"y_pos",
                               nil],
                              nil];
            
            NSDictionary* tap_no_objects=[NSDictionary dictionaryWithObjectsAndKeys:
            @"0", @"count",
            tapsNoObjects, @"taps",
            nil];
            
            NSDictionary* tap_on_objects=[NSDictionary dictionaryWithObjectsAndKeys:
            @"0", @"count",
            @"[1]", @"taps",
            nil];
            
            NSDictionary* general=[NSDictionary dictionaryWithObjectsAndKeys:
                                   tap_on_objects, @"tap_on_objects",
                                   tap_no_objects, @"tap_no_objects",
                                   elements_array, @"elements",
                                   @"0", @"num_elements",
                                   @"0", @"elapsed_time",
                                   @"0", @"fails",
                                   @"0", @"success",
                                          nil];
            
            NSDictionary* data=[NSDictionary dictionaryWithObjectsAndKeys:
                                //responsiveness, @"responsiveness",
                                general, @"general",
                                   nil];
            
            NSDictionary* datos=[NSDictionary dictionaryWithObjectsAndKeys:
            gameplay_uuid, @"gameplay_uuid",
            player_uuid, @"player_uuid",
            contentapp_uuid, @"contentapp_uuid",
            data, @"data",
            nil];
