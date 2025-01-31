/*
 *  class chapter_04
 *
 *
 *  Can NOT be used in network game !
 */

//Step 4 =====================================================================================
ch4_cov_lim1 <- {a = 9, b = 15}

//Step 5 =====================================================================================
ch4_cov_lim2 <- {a = 14, b = 20}

//Step 7 =====================================================================================
ch4_cov_lim3 <- {a = 19, b = 21}


class tutorial.chapter_04 extends basic_chapter
{
	chapter_name  = "Setting Sail"
	chapter_coord = coord(95,39)

	startcash     = 1000000	   				// pl=0 startcash; 0=no reset
	gl_wt = wt_water

	wayend = 0
	coorbord = 0
	cov_cir = 0

	//Step 1 =====================================================================================
	//Productor
	f1name = "Oelbohrinsel"
	f1_coord = coord(113,57)
	f1_good = good_alias.oel
	f1_lim = {a = coord(113,57), b = coord(115,59)}

	//Fabrica
	f2name = "Raffinerie"
	f2_coord = coord(95,39)
	f2_good = good_alias.gas
	f2_lim = {a = coord(95,39), b = coord(97,41)}

	//Step 2 =====================================================================================
	//Para los muelles
	dock_list1 = [coord(94,42)]

	//Step 3 =====================================================================================
	c_dep1 = coord(113,69)
	d1_cnr = 5

	//Step 4 =====================================================================================
	ship1_name_obj = "MHz-OT5_Oil_Barge"
	ship1_load = 100
	ship1_wait = 0

	sch_list1 = [coord(113,57), coord(93,42)]

	//Step 5 =====================================================================================
	//Para el canal acuatico
	c_way = {a = coord3d(84,43,-1), b = coord3d(80,33,-1)}
	c_way_lim = {a = coord(78,32), b = coord(84,46)}

	//Para Astillero
	c_dep2 = coord(94,44)

	//Consumidor Final
	f3name = "TANKE1"
	f3_coord = coord(80,30)
	f3_good = good_alias.gas
	d2_cnr = 5

	sch_list2 = [coord(93,42), coord(80,33)]

	//Step 6 =====================================================================================
	sch_list3 = [coord(98,47), coord(92,63), coord(88,71), coord(92,63)]
	dock_list2 = [coord(98,46), coord(91,63), coord(88,70)]

	//Step 7 =====================================================================================
	tur = coord(88,65)
	ship2_name_obj = "MV_Balmoral"

	ship2_load = 100
	ship2_wait = 42282
	line1_name = "Test 5"

	//Script
	//----------------------------------------------------------------------------------
	sc_way_name = "canal_030"
	sc_dock_name1 = "Long_Goods_Dock"
	sc_dock_name2 = "canal_ware_stop"
	sc_dock_name3 = "ShipStop"
	sc_dep_name = "ShipDepot"

	comm_script = false

	function start_chapter()  //Inicia solo una vez por capitulo
	{		
		rules.clear()
		set_all_rules(0)

		local pl = 0
		if(this.step == 7){
            local c_dep = this.my_tile(c_dep2)
			local c_list = sch_list3
			start_sch_tmpsw(pl,c_dep, c_list)
		}

		return 0
	}

	function set_goal_text(text){
	switch (this.step) {
		case 1:

			if (pot0==0){
				text = ttextfile("chapter_04/01_1-2.txt")
				text.tx=ttext("<em>[1/2]</em>")
			}
			else {
				text = ttextfile("chapter_04/01_2-2.txt")
				text.tx=ttext("<em>[2/2]</em>")
			}
			break
		case 2:
			local c_list = dock_list1
			local txdoc = ""
            local dock_name = translate("Dock")
            local ok_tex = translate("OK")
			for(local j=0;j<c_list.len();j++){
				if (glsw[j]==0)
					txdoc += format("<a><st>%s %d</st>",dock_name,j+1) + c_list[j].href(" ("+c_list[j].tostring()+")")+"<br>" 
				else
					txdoc += format("<em>%s %d</em>",dock_name,j+1) + " ("+c_list[j].tostring()+") <em>"+ok_tex+"</em><br>" 
			}
			text.nr = c_list.len()
			text.dock = txdoc
			break
		case 3:
			
			break
		case 4:
			text.all_cov = d1_cnr
			text.load = ship1_load
			text.wait = get_wait_time_text(ship1_wait)
			break

		case 5:
			local c1 = coord(c_way.a.x, c_way.a.y)
			local c2 = coord(c_way.b.x, c_way.b.y)
			if(!correct_cov){
				local a = 4
				local b = 4
				text = ttextfile("chapter_04/05_"+a+"-"+b+".txt")
				text.tx=ttext("<em>["+a+"/"+b+"]</em>")
			}
			else if (pot0==0){
				local a = 1
				local b = 4
				text = ttextfile("chapter_04/05_"+a+"-"+b+".txt")
				text.tx=ttext("<em>["+a+"/"+b+"]</em>")
			}
			else if (pot1==0){
				local a = 2
				local b = 4
				text = ttextfile("chapter_04/05_"+a+"-"+b+".txt")
				text.tx=ttext("<em>["+a+"/"+b+"]</em>")
			}
			else if (pot2==0){
				local a = 3
				local b = 4
				text = ttextfile("chapter_04/05_"+a+"-"+b+".txt")
				text.tx=ttext("<em>["+a+"/"+b+"]</em>")
			}
			else if (pot3==0){
				local a = 4
				local b = 4
				text = ttextfile("chapter_04/05_"+a+"-"+b+".txt")
				text.tx=ttext("<em>["+a+"/"+b+"]</em>")
			}
			text.w1 = c1.href(" ("+c1.tostring()+")")+""
			text.w2 = c2.href(" ("+c2.tostring()+")")+""
			text.dock = sch_list2[1].href("("+sch_list2[1].tostring()+")")+""
			text.all_cov = d1_cnr
			text.load = ship1_load
			text.wait = get_wait_time_text(ship1_wait)
			
			break

		case 6:
			local c_list = dock_list2
			local txdoc = ""
            local dock_name = translate("Dock")
            local ok_tex = translate("OK")
			for(local j=0;j<c_list.len();j++){
				if (glsw[j]==0)
					txdoc += format("<a><st>%s %d</st>",dock_name,j+1) + c_list[j].href(" ("+c_list[j].tostring()+")")+"<br>" 
				else
					txdoc += format("<em>%s %d</em>",dock_name,j+1) + " ("+c_list[j].tostring()+") <em>"+ok_tex+"</em><br>" 
			}
			text.nr = c_list.len()
			text.dock = txdoc
			break

		case 7:
			local tx_list = ""
			local nr = sch_list3.len()
			local list = sch_list3
			for (local j=0;j<nr;j++){
				local c = coord(list[j].x, list[j].y)
				local tile = my_tile(c)
				local st_halt = tile.get_halt()

				if(tmpsw[j]==0 ){
					tx_list += format("<st>%s %d:</st> %s<br>", translate("Stop"), j+1, c.href(st_halt.get_name()+" ("+c.tostring()+")"))
				}
				else{						
					tx_list += format("<em>%s %d:</em> %s <em>%s</em><br>", translate("Stop"), j+1, st_halt.get_name(), translate("OK"))
				}
			}
			local c = coord(list[0].x, list[0].y)
			text.stnam = "1) "+my_tile(c).get_halt().get_name()+" ("+c.tostring()+")"
			text.list = tx_list			
			text.ship = translate(ship2_name_obj)
			text.load = ship2_load
			text.wait = get_wait_time_text(ship2_wait)
			break

		case 8:

			break

		}
		text.dep1 = c_dep1.href("("+c_dep1.tostring()+")")+""
		text.dep2 = c_dep2.href("("+c_dep2.tostring()+")")+""
		text.sh = translate(ship1_name_obj)
		text.cir = cov_cir
		text.f1 = f1_coord.href(""+translate(f1name)+" ("+f1_coord.tostring()+")")+""
		text.f3 = f2_coord.href(""+translate(f2name)+" ("+f2_coord.tostring()+")")+""
		text.f4 = f3_coord.href(""+translate(f3name)+" ("+f3_coord.tostring()+")")+""
		text.tur = tur.href(" ("+tur.tostring()+")")+""
		text.good1 = translate(f1_good)
		text.good2 = translate(f2_good)
		text.good3 = translate(f3_good)

		return text
	}
	
	function is_chapter_completed(pl) {
		local percentage=0
		persistent.point = point
		save_pot()
		save_glsw()
		switch (this.step) {
			case 1:
				return 5
				break;
			case 2:
				//Para los Muelles
				local siz = dock_list1.len()
				local c_list = dock_list1
				local name = translate("Build a Dock here!.")
				local good = good_alias.goods
				local label = true
				local all_stop = is_stop_building(siz, c_list, name, good, label)
				
				if (all_stop) {
					this.next_step()
				}

				return 5
				break;
			case 3:
				//Para Astillero
				local t1 = my_tile(c_dep1)
				local depot = t1.find_object(mo_depot_water)

				if (!depot){
					label_x.create(c_dep1, player_x(0), translate("Build Shipyard here!."))
				}
				else{
					t1.remove_object(player_x(0), mo_label)
					glsw[0]=1
				}
				return 10+percentage
				break
			case 4:			
				cov_cir = get_convoy_nr((ch4_cov_lim1.a), d1_cnr)

				if (cov_cir == d1_cnr){
					reset_stop_flag()
					this.next_step()
				}
				return 50
				break
			case 5:
				//Para el canal acuatico
				if (pot0==0){
					//Inicio del canal
					local c_start = coord(c_way.a.x, c_way.a.y)
					local t_start = my_tile(c_start)
					local way_start = t_start.find_object(mo_way)
					if (way_start && way_start.get_desc().get_topspeed()==0){
						t_start.mark()
						label_x.create(c_start, player_x(1), translate("Build Canal here!."))
					}
					else{
						t_start.unmark()
						t_start.remove_object(player_x(1), mo_label)
					}

					//Final del canal
					local c_end = coord(c_way.b.x, c_way.b.y)
					local t_end = my_tile(c_end)
					local way_end = t_end.find_object(mo_way)
					if (!way_end){
						t_end.mark()
						label_x.create(c_end, player_x(1), translate("Build Canal here!."))
					}
					else{
						t_end.unmark()
						t_end.remove_object(player_x(1), mo_label)
					}

					local coora = {x = c_way.a.x, y = c_way.a.y, z = c_way.a.z }
					local coorb = {x = c_way.b.x, y = c_way.b.y, z = c_way.b.z }
					local obj = false
					local dir = 6
					wayend = coorb
					local fullway = get_fullway(coora, coorb, dir, obj)

					if (fullway==0){	
						wayend = 0
						coorbord = 0
						pot0=1		
					}
					else 
						coorbord = fullway
				}
				//Para el cuarto muelle
				else if (pot0==1 && pot1==0){
					local t = my_tile(sch_list2[1])
					local dock4 = t.find_object(mo_building)
					if (!dock4){
					label_x.create(sch_list2[1], player_x(0), translate("Build a Dock here!."))
					}
					else{
						if (is_station_build(0, sch_list2[1], good_alias.goods)==null)
							pot1=1
					}
				}
				//Para Astillero
				else if (pot1==1 && pot2==0){
					local t1 = tile_x(c_dep2.x, c_dep2.y, 0)
					local depot = t1.find_object(mo_depot_water)

					if (!depot){
						label_x.create(c_dep2, player_x(0), translate("Build Shipyard here!."))
					}
					else{
						t1.remove_object(player_x(0), mo_label)
						pot2=1
					}
				}
				//Vehiculos en circulacion
				else if (pot2==1 && pot3==0){
					cov_cir = get_convoy_nr((ch4_cov_lim2.a ), d2_cnr)

					if (cov_cir==d2_cnr)
						pot3=1
				}
				if (pot3==1 && pot4==0){
					reset_stop_flag()
					this.next_step()
				}	
				return 65
				break
			case 6:
				//Para los Muelles
				local siz = dock_list2.len()
				local c_list = dock_list2
				local name = translate("Build a Dock here!.")
				local good = good_alias.passa
				local label = true
				local all_stop = is_stop_building(siz, c_list, name, good, label)
				
				if (all_stop) {
					this.next_step()
				}

				return 0
				break

			case 7:
                local c_dep = this.my_tile(c_dep2)
                local line_name = line1_name
                set_convoy_schedule(pl,c_dep, gl_wt, line_name)
				if(current_cov == ch4_cov_lim3.b){
					this.next_step()
				}
				return 0
				break

			case 8:
				reset_stop_flag()
				this.next_step()
				return 0
				break

			case 9:
				this.step=1
				persistent.step=1
				persistent.status.step = 1
				persistent.point = null
				return 100
				break
		}
		percentage=(this.step-1)+1
		return percentage
	}
	
	function is_work_allowed_here(pl, tool_id, pos) {
		glpos = coord3d(pos.x, pos.y, pos.z)
		local t = tile_x(pos.x, pos.y, pos.z)
		local ribi = 0
		local wt = 0
		local slope = t.get_slope()
		local way = t.find_object(mo_way)
		local bridge = t.find_object(mo_bridge)
		local label = t.find_object(mo_label)
		local building = t.find_object(mo_building)
		local sign = t.find_object(mo_signal)
		local roadsign = t.find_object(mo_roadsign)
		if (way){
			wt = way.get_waytype()
			if (tool_id!=4111)
				ribi = way.get_dirs()
			//if (!t.has_way(gl_wt))
				//ribi = 0
		}
		local result = translate("Action not allowed")		// null is equivalent to 'allowed'
		//glbpos = coord3d(pos.x,pos.y,pos.y)
		gltool = tool_id			
		switch (this.step) {
			case 1:
				if ((pos.x>=f2_lim.a.x)&&(pos.y>=f2_lim.a.y)&&(pos.x<=f2_lim.b.x)&&(pos.y<=f2_lim.b.y)){
					if (tool_id == 4096){
						if (pot0==0){
							pot0=1
							return null
						}			
					}
					else
						translate("You must use the inspection tool")+" ("+pos.tostring()+")."	
				}

				if ((pos.x>=f1_lim.a.x)&&(pos.y>=f1_lim.a.y)&&(pos.x<=f1_lim.b.x)&&(pos.y<=f1_lim.b.y)){
					if (tool_id == 4096){
						if (pot0==1){
							this.next_step()
							return null
						}			
					}
					else
						translate("You must use the inspection tool")+" ("+pos.tostring()+")."	
				}
		
				break;
			//Construyendo los Muelles
			case 2:
				local c_list = dock_list1
				local good = good_alias.goods
				if((tool_id != 4096))
					return is_dock_build(pos, tool_id, c_list, good)
				break
			case 3:
				//Primer Astillero
				if (pos.x==c_dep1.x && pos.y==c_dep1.y){			
					if (glsw[0]==0){
						if (tool_id==4117){
							return null
						}
					}
					else if (glsw[0]==1 && glsw[1]==0){
						if (tool_id==4096){
							this.next_step()
							return null
						}
					}
				}
				else if (glsw[0]==0)
					result = translate("Place the shipyard here")+" ("+c_dep1.tostring()+")."
				break
			//Enrutar barcos
			case 4:
				if (tool_id==4108){
					local c_list = sch_list1	//Lista de todas las paradas de autobus
					local c_dep = c_dep1		//Coordeadas del deposito 
					local siz = c_list.len()	//Numero de paradas 
					result = translate("The route is complete, now you may dispatch the vehicle from the depot")+" ("+c_dep.tostring()+")."
					return is_stop_allowed_ex(result, siz, c_list, pos, gl_wt)					
				}						
				break
			case 5:
				if (pot0==0){
                    if(pos.x==c_way.a.x && pos.y==c_way.a.y){
                        if(tool_id==tool_remove_way || tool_id==4097)
							return result
                    }
					if (pos.x>=c_way_lim.a.x && pos.y>=c_way_lim.a.y && pos.x<=c_way_lim.b.x && pos.y<=c_way_lim.b.y){
						return all_control(result, gl_wt, way, ribi, tool_id, pos, coorbord)	
					}
				}
				//Cuarto muelle
				else if(pot0==1 && pot1==0){
					if(my_tile(sch_list2[1]).find_object(mo_building)){
						if (tool_id==4097)
							return null
						if (is_station_build(0, sch_list2[1], good_alias.goods)!=null)
							return format(translate("Dock No.%d must accept goods"),4)+" ("+sch_list2[1].tostring()+")."
					}					
					if(pos.x==sch_list2[1].x && pos.y==sch_list2[1].y){
						if(tool_id==tool_build_station){
							t.remove_object(player_x(0), mo_label)
							return null
						}	
					}
				}
				//Para Astillero
				else if (pot1==1 && pot2==0){
					if (pos.x==c_dep2.x && pos.y==c_dep2.y){			
						if (tool_id==4117){
							return null
						}
					}
				}
				//Enrutar Barcos
				else if (pot2==1 && pot3==0){
					if (tool_id==4108){
						local c_list = sch_list2	//Lista de todas las paradas de autobus
						local c_dep = c_dep2		//Coordeadas del deposito 
						local siz = c_list.len()	//Numero de paradas 
						result = translate("The route is complete, now you may dispatch the vehicle from the depot")+" ("+c_dep.tostring()+")."
						return is_stop_allowed_ex(result, siz, c_list, pos, gl_wt)	
					}
				}
				break

			case 6:

				local c_list = dock_list2
				local good = good_alias.passa
				if((tool_id != 4096))
					return is_dock_build(pos, tool_id, c_list, good)

				break

			case 7:
				if (tool_id==4108){
					local c_list = sch_list3	//Lista de todas las paradas de autobus
					local c_dep = c_dep2		//Coordeadas del deposito 
					local siz = c_list.len()	//Numero de paradas 
					result = translate("The route is complete, now you may dispatch the vehicle from the depot")+" ("+c_dep.tostring()+")."
					return is_stop_allowed_ex(result, siz, c_list, pos, gl_wt)
				}
				break
		}
		if (tool_id == 4096){
			if (label && label.get_text()=="X")
				return translate("Indicates the limits for using construction tools")+" ("+pos.tostring()+")."		
			else if (label)	
				return translate("Text label")+" ("+pos.tostring()+")."
			result = null	// Always allow query tool
		}
		if (label && label.get_text()=="X")
			return translate("Indicates the limits for using construction tools")+" ("+pos.tostring()+")."	

		return result	
	}
	
	function is_schedule_allowed(pl, schedule) {
		local result=null	// null is equivalent to 'allowed'
		local nr =  schedule.entries.len()
		switch (this.step) {
			case 4:
				local selc = 0
				local load = ship1_load
				local time = ship1_wait
				local c_list = sch_list1
				local siz = c_list.len()
				return set_schedule_list(result, pl, schedule, nr, selc, load, time, c_list, siz)			
			break
			case 5:
				local selc = 0
				local load = ship1_load
				local time = ship1_wait
				local c_list = sch_list2
				local siz = c_list.len()
				return set_schedule_list(result, pl, schedule, nr, selc, load, time, c_list, siz)	
			break
			case 7:
				local selc = 0
				local load = ship2_load
				local time = ship2_wait
				local c_list = sch_list3
				local siz = c_list.len()
				result = set_schedule_list(result, pl, schedule, nr, selc, load, time, c_list, siz)
				if(result == null){
					local line_name = line1_name
					update_convoy_schedule(pl, gl_wt, line_name, schedule)
				}
				return result
			break
		}
		return translate("Action not allowed")
	}

	function is_convoy_allowed(pl, convoy, depot)
	{
		local result=null	// null is equivalent to 'allowed'
		local wt = gl_wt
		switch (this.step) {
			case 4:
				if(comm_script) {
					cov_save[current_cov]=convoy
					id_save[current_cov]=convoy.id
					gcov_nr++
					persistent.gcov_nr = gcov_nr
					current_cov++
					gall_cov++
					return null
				}
				if ((depot.x != c_dep1.x)||(depot.y != c_dep1.y))
					return translate("You must select the deposit located in")+" ("+c_dep1.tostring()+")."	
				local cov = d1_cnr
				local in_dep = true
				local veh = 1
				local good_list = [good_desc_x(f1_good).get_catg_index()] //Fuels
				local name = ship1_name_obj
				local st_tile = 1

				//Para arracar varios vehiculos
				local id_start = ch4_cov_lim1.a
				local id_end = ch4_cov_lim1.b
				local cir_nr = get_convoy_number_exp(sch_list1[0], depot, id_start, id_end)
				cov -= cir_nr
		
				result = is_convoy_correct(depot,cov,veh,good_list,name,st_tile)

				if (result!=null){
					local name = translate(ship1_name_obj)
					local good = translate(f1_good)
	 				return ship_result_message(result, name, good, veh, cov)
				}

				if (current_cov>ch4_cov_lim1.a && current_cov<ch4_cov_lim1.b){
					local selc = 0
					local load = ship1_load
					local time = ship1_wait
					local c_list = sch_list1
					local siz = c_list.len()
					return set_schedule_convoy(result, pl, cov, convoy, selc, load, time, c_list, siz)
				}
				
			break
			case 5:
				if(comm_script) {
					cov_save[current_cov]=convoy
					id_save[current_cov]=convoy.id
					gcov_nr++
					persistent.gcov_nr = gcov_nr
					current_cov++
					gall_cov++
					return null
				}

				if ((depot.x != c_dep2.x)||(depot.y != c_dep2.y))
					return translate("You must select the deposit located in")+" ("+c_dep1.tostring()+")."
				local cov = d2_cnr
		        local in_dep = true
				local veh = 1
				local good_list = [good_desc_x(f2_good).get_catg_index()] //Fuels
				local name = ship1_name_obj
				local st_tile = 1

				//Para arracar varios vehiculos
				local id_start = ch4_cov_lim2.a
				local id_end = ch4_cov_lim2.b
				local cir_nr = get_convoy_number_exp(sch_list2[1], depot, id_start, id_end)
				cov -= cir_nr

				result = is_convoy_correct(depot,cov,veh,good_list,name,st_tile)
				if (result!=null){
					local name = translate(ship1_name_obj)
					local good = translate(f2_good)
	 				return ship_result_message(result, name, good, veh, cov)
				}
				if (current_cov>ch4_cov_lim2.a && current_cov<ch4_cov_lim2.b){
					local selc = 0
					local load = ship1_load
					local time = ship1_wait
					local c_list = sch_list2
					local siz = c_list.len()
					return set_schedule_convoy(result, pl, cov, convoy, selc, load, time, c_list, siz)
				}
			break
			case 7:
				if ((depot.x != c_dep2.x)||(depot.y != c_dep2.y))
					return translate("You must select the deposit located in")+" ("+c_dep1.tostring()+")."
				local cov = 1
				local veh = 1
				local good_list = [good_desc_x(good_alias.passa).get_catg_index()] //Passengers
				local name = ship2_name_obj
				local st_tile = 1

				result = is_convoy_correct(depot,cov,veh,good_list,name,st_tile)

				if (result!=null){
					local name = translate(ship2_name_obj)
					local good = translate("Passengers")
	 				return ship_result_message(result, name, good, veh, cov)
				}
				if (current_cov>ch4_cov_lim3.a && current_cov<ch4_cov_lim3.b){
					local selc = 0
					local load = ship2_load
					local time = ship2_wait
					local c_list = sch_list3
					local siz = c_list.len()
					return set_schedule_convoy(result, pl, cov, convoy, selc, load, time, c_list, siz)
				}
			break
		}
		return result = translate("It is not allowed to start vehicles.")
	}

	function script_text()
	{
		switch (this.step) {
			case 1:
				this.next_step()
				return null
				break;
			case 2:
				//Para los muelles mrcancias
				local c_list = dock_list1
				local name = sc_dock_name1
				for(local j =0;j<c_list.len();j++){
					local tile = my_tile(c_list[j])
					tile.remove_object(player_x(0), mo_label)
					local tool = command_x(tool_build_station)			
					local err = tool.work(player_x(0), tile, name)
				}
				return null
				break;

			case 3:
				//Para Astillero
				local t1 = my_tile(c_dep1)
				local label = t1.find_object(mo_label)

				if (label){
					t1.remove_object(player_x(0), mo_label)
				}
				
				local tool = command_x(tool_build_depot)			
				local err = tool.work(player_x(0), t1, sc_dep_name)

				if (t1.find_object(mo_depot_water)){
					this.next_step()
				}
				return null
				break;

			case 4:
				local pl = player_x(0)
				local c_depot = my_tile(c_dep1)

				comm_destroy_convoy(pl, c_depot) // Limpia los vehiculos del deposito

				local depot = c_depot.find_object(mo_depot_water)
				local good_nr = good_desc_x(f1_good).get_catg_index()  //Fuels
				local name = ship1_name_obj

				comm_script = true 
				if (current_cov> ch4_cov_lim1.a && current_cov< ch4_cov_lim1.b){
					local cov_nr = d1_cnr  //Max convoys nr in depot
					local sched1 = schedule_x(gl_wt, [])
					local c_list1 = sch_list1
					for(local j =0;j<c_list1.len();j++){
						if(j == 0)
							sched1.entries.append(schedule_entry_x(my_tile(c_list1[j]), ship1_load, ship1_wait))
						else
							sched1.entries.append(schedule_entry_x(my_tile(c_list1[j]), 0, 0))
					}
					local hold_cov = current_cov
					for (local j = hold_cov; j<(cov_nr+hold_cov) && correct_cov; j++){
						if (!comm_set_convoy(cov_nr, c_depot, name))
							return 0
						local convoy = depot.get_convoy_list()
						comm_start_convoy(pl, gl_wt, sched1, convoy, depot)
					}								
				}	
				comm_script = false
				reset_pot()
				reset_glsw()
				reset_stop_flag()

				return null
				break;

			case 5:
				//Para el canal acuatico
				if (pot0==0){
					local t1 = my_tile(coord(c_way.a.x, c_way.a.y))
					local t2 = my_tile(sch_list2[1])
					local way = t1.find_object(mo_way)
					local is_lab1 = t1.find_object(mo_label)
					local is_lab2 = t2.find_object(mo_label)

					t1.unmark()

					if (is_lab1){
						t1.remove_object(player_x(1), mo_label)
					}
					if (is_lab2){
						t2.remove_object(player_x(1), mo_label)
					}
					if (way)
						way.unmark()

					local coora = {x = c_way.a.x, y = c_way.a.y, z = c_way.a.z }
					local coorb = {x = c_way.b.x, y = c_way.b.y, z = c_way.b.z }
					
					local t = command_x(tool_build_way)	
					t.set_flags(2)		
					local err = t.work(player_x(1), coora, coorb, sc_way_name)

					pot0=1
				}
				//Para el cuarto muelle
				if (pot0==1 && pot1==0){
					local t = my_tile(sch_list2[1])
					local label = t.find_object(mo_label)
					if (label){
						t.remove_object(player_x(1), mo_label)
					}
					local tool = command_x(tool_build_station)			
					local err = tool.work(player_x(0), t, sc_dock_name2)

					pot1=1
				}
				//Para Astillero
				if (pot1==1 && pot2==0){
					local t1 = my_tile(c_dep2)
					local label = t1.find_object(mo_label)

					if (label){
						t1.remove_object(player_x(0), mo_label)
					}
					
					local tool = command_x(tool_build_depot)			
					local err = tool.work(player_x(0), t1, sc_dep_name)

					pot2 = 1
				}
				if (current_cov> ch4_cov_lim2.a && current_cov< ch4_cov_lim2.b){

					local pl = player_x(0)
					local c_depot = my_tile(c_dep2)

					comm_destroy_convoy(pl, c_depot) // Limpia los vehiculos del deposito

					local depot = c_depot.find_object(mo_depot_water)
					local good_nr = good_desc_x(f2_good).get_catg_index()  //Fuels
					local name = ship1_name_obj
					local cov_nr = d2_cnr  //Max convoys nr in depot

					comm_script = true 
					local sched = schedule_x(gl_wt, [])
					local c_list = sch_list2
					sched.entries.append(schedule_entry_x(my_tile(c_list[0]), ship1_load, ship1_wait))
					sched.entries.append(schedule_entry_x(my_tile(c_list[1]), 0, 0))
					local hold_cov = current_cov
					for (local j = hold_cov; j<(cov_nr+hold_cov) && correct_cov; j++){
						if (!comm_set_convoy(cov_nr, c_depot, name))
							return 0
						local convoy = depot.get_convoy_list()
						comm_start_convoy(pl, gl_wt, sched, convoy, depot)
					}
					comm_script = false
					pot3=1
				}
				return null
				break;

			case 6:
				local t_dep = my_tile(c_dep2)
				local depot = t_dep.find_object(mo_depot_water)

				if (!depot){
					local t = command_x(tool_build_depot)			
					local err = t.work(player_x(0), t_dep, sc_dep_name)
				}
				//Para los muelles mercancias
				local c_list = dock_list2
				local name = sc_dock_name3
				for(local j =0;j<c_list.len();j++){
					local tile = my_tile(c_list[j])
					tile.remove_object(player_x(0), mo_label)
					local tool = command_x(tool_build_station)			
					local err = tool.work(player_x(0), tile, name)
					glsw[j]=1
				}
				return null
				break;

			case 7:
				local pl = player_x(0)
				local c_depot = my_tile(c_dep2)

				comm_destroy_convoy(pl, c_depot) // Limpia los vehiculos del deposito

				local depot = c_depot.find_object(mo_depot_water)

				local good_nr = good_desc_x(good_alias.passa).get_catg_index() //Passengers
				local name = ship2_name_obj

				local cov_nr = 1  //Max convoys nr in depot

				local sched = schedule_x(gl_wt, [])
				local c_list = sch_list3
				for(local j =0;j<c_list.len();j++){
					if(j == 0)
						sched.entries.append(schedule_entry_x(my_tile(c_list[j]), ship2_load, ship2_wait))
					else
						sched.entries.append(schedule_entry_x(my_tile(c_list[j]), 0, 0))
				}

				if (!comm_set_convoy(cov_nr, c_depot, name))
					return 0

				local convoy = depot.get_convoy_list()
				comm_start_convoy(pl, gl_wt, sched, convoy, depot)
				
				return null
				break;
		}
		return null
	}
	
	function set_all_rules(pl) 
	{
		local forbid =	[	4129,tool_build_way,tool_build_bridge,tool_build_tunnel,tool_build_station,
							tool_remove_way,tool_build_depot,tool_build_roadsign,tool_build_wayobj
						]
		foreach(wt in all_waytypes)
			if (wt != wt_water){
				foreach (tool_id in forbid)
					rules.forbid_way_tool(pl, tool_id, wt )
				}

		local forbid = [tool_setslope]
		foreach (tool_id in forbid)
		rules.forbid_tool(pl, tool_id )

			
		local forbid =	[	4134, 4135, tool_lower_land, tool_raise_land, tool_restoreslope, tool_add_city,
							tool_make_stop_public, 4137, tool_build_transformer, 4107, 4102, 4127, 4131
						]

		foreach (tool_id in forbid)
			rules.forbid_tool(pl, tool_id )

		switch (this.step) {
			case 1:
				local forbid =	[	4097,4134,4135,tool_lower_land,tool_raise_land,tool_restoreslope,
									tool_make_stop_public,tool_build_transformer,tool_build_station,
									tool_build_way,tool_build_bridge,tool_build_depot,tool_remove_way
								]
				foreach (tool_id in forbid)
					rules.forbid_tool(pl, tool_id )
				break

			case 2:
				local forbid =	[	tool_build_roadsign,tool_build_bridge,tool_build_station,
									tool_build_depot,tool_build_roadsign,tool_build_wayobj
								]
					foreach (tool_id in forbid)
						rules.forbid_way_tool(pl, tool_id, wt_rail )

				local forbid = [tool_build_depot,tool_build_way,tool_build_bridge,tool_build_tunnel,tool_remove_way]
				foreach (tool_id in forbid)
					rules.forbid_tool(pl, tool_id )			
				break

			case 3:
				local forbid =	[	tool_build_roadsign,tool_build_bridge,tool_build_station,tool_build_tunnel,
									tool_build_depot,tool_build_roadsign,tool_build_wayobj
								]
					foreach (tool_id in forbid)
						rules.forbid_way_tool(pl, tool_id, wt_rail )

				local forbid = [tool_build_station,tool_build_way,tool_build_bridge,tool_build_tunnel,tool_remove_way,tool_remover]
				foreach (tool_id in forbid)
					rules.forbid_tool(pl, tool_id )	
				break

			case 4:
				local forbid =[tool_build_bridge,tool_build_tunnel,tool_remove_way,tool_build_roadsign,tool_build_wayobj]
					foreach (tool_id in forbid)
						rules.forbid_way_tool(pl, tool_id, wt_rail )

				local forbid = [tool_build_station,tool_build_way,tool_build_bridge,tool_build_tunnel,tool_remove_way,tool_remover]
				foreach (tool_id in forbid)
					rules.forbid_tool(pl, tool_id )	
				break

			case 5:
				local forbid =	[	tool_build_bridge,tool_build_tunnel,tool_build_station,
									tool_remove_way,tool_build_roadsign,tool_build_wayobj
								]
					foreach (tool_id in forbid)
						rules.forbid_way_tool(pl, tool_id, wt_rail )
				break

			case 6:
				local forbid = [tool_build_way,tool_build_bridge,tool_build_tunnel,tool_build_depot,tool_build_roadsign,tool_build_wayobj]
					foreach (tool_id in forbid)
						rules.forbid_way_tool(pl, tool_id, wt_rail )

				local forbid = [tool_build_way,tool_build_bridge,tool_build_tunnel,tool_remove_way]
				foreach (tool_id in forbid)
					rules.forbid_tool(pl, tool_id )	
				break

			case 7:
				local forbid = [tool_build_tunnel,tool_build_depot,tool_build_roadsign,tool_build_wayobj]
					foreach (tool_id in forbid)
						rules.forbid_way_tool(pl, tool_id, wt_rail )

				local forbid = [tool_build_station,tool_build_depot,tool_build_way,tool_build_bridge,tool_build_tunnel,tool_remove_way,tool_remover]
				foreach (tool_id in forbid)
					rules.forbid_tool(pl, tool_id )
				break

		
		}
	}
	function is_dock_build(pos, tool_id, c_list, good)
	{
		local result = 0
		local st = {all_correct = true, c = null, nr = 0}
		local err_tx = translate("Dock No.%d must accept [%s]")
		local siz = c_list.len()
		for(local j=0;j<siz;j++){
			local tile = my_tile(c_list[j])
			local halt = tile.get_halt()
			local buil = tile.find_object(mo_building)
			if(buil && st.all_correct){ 
				local st_list = building_desc_x.get_available_stations(11/*building_desc_x.station*/, 3, good_desc_x(good))
				local st_desc = buil.get_desc()
				local sw = false
				
				//gui.add_message(""+st_desc.get_type()+"  , "+st_desc.get_waytype()+"")
				foreach(st in st_list){
					if (st.get_name() == st_desc.get_name())
						sw=true
				}
				//gui.add_message(""+sw+"  , "+st_desc.get_waytype()+"")
				if(!sw){
					st.all_correct = false
					st.c = c_list[j]
					st.nr = j+1
				}
			}
			if (pos.x == c_list[j].x && pos.y == c_list[j].y){
				if(tool_id==tool_build_station){
					if(st.all_correct) result = null
				}	
			}
			else if(tool_id==tool_build_station && result!=null){
				local c = coord(c_list[siz-j-1].x,c_list[siz-j-1].y)
				local tile = my_tile(c)
				local buil = tile.find_object(mo_building)
				//local current_halt = my_tile(st.c).get_halt()
				if(!buil)
					result = translate("Place the stops at the marked points")+" ("+c.tostring()+")."
			}
			if (j == (siz-1)){

				if (tool_id==tool_remover && !st.all_correct){
					local current_halt = my_tile(st.c).get_halt()
					if(current_halt){
						local tile_list = current_halt.get_tile_list()
						foreach(tile in tile_list){
							if(pos.x == tile.x && pos.y == tile.y)
								return null
						}
					}
				}
									
				if(!st.all_correct){ 
					result =  st.c ? format(err_tx, st.nr, translate(good))+" ("+st.c.tostring()+")." : translate("Action not allowed")
				}
				if(result == 0){
					result =  translate("Action not allowed")
				}
			}
		}
		return result
	}

	function ship_result_message(nr, name, good, veh, cov)
	{
		switch (nr) {
			case 0:
				return format(translate("You must select a [%s]."),name)
				break

			case 1:
				return format(translate("The number of ships must be [%d]."),cov)
				break

			case 2:
				return format(translate("The number of convoys must be [%d], press the [Sell] button."),cov)
				break

			case 3:
				return format(translate("The ship must be for [%s]."),good)
				break

			case 4:
				return translate("No barges allowed.")
				break

			default :
				return translate("The convoy is not correct.")
				break
		}
	}

	function update_way(coora, coorb, vel_min, wt)
	{
		local tile_start =  tile_x(coora.x, coora.y, coora.z)
		local way_start = tile_start.find_object(mo_way)
		if(way_start){
			way_start.mark()
			tile_start.mark()
			local start_wt = way_start.get_waytype()
			if(start_wt != wt) return {c = coora, result = false}
			local start_speed = way_start.get_desc().get_topspeed()
			if(start_speed<vel_min) return {c = coora, result = false}
			local dir_start = way_start.get_dirs()
			switch (dir_start) {
				case 1:  //y--
					coora.y--
				break
				case 2:  //x++
					coora.x++
				break
				case 4:  //y++
					coora.y++
				break
				case 8:  //x--
					coora.x--
				break
				default:
					if(coora.x >= coorb.x && coora.y == coorb.y){
						coora.x--
						dir_start = 8
					}
					else if(coora.x <= coorb.x && coora.y == coorb.y){
						coora.x++
						dir_start = 2
					}

					else if(coora.x == coorb.x && coora.y >= coorb.y){
						coora.y--
						dir_start = 4
					}
					else if(coora.x == coorb.x && coora.y <= coorb.y){
						coora.y++
						dir_start = 1
					}

				break
			}
			way_start.unmark()
			tile_start.unmark()
			while(true){
				local dir = 0
				local tile = tile_x(coora.x, coora.y, coora.z)
				local way = tile.find_object(mo_way)
				if(way){
					way.unmark()
					tile.unmark()
					local current_wt = way.get_waytype()
					if(current_wt != wt){
						way.mark()
						tile.mark()
						return {c = coora, result = false}
					}
					local speed = way.get_desc().get_topspeed()
					if(speed<vel_min){
						way.mark()
						tile.mark()
						return {c = coora, result = false}
					}
					dir = way.get_dirs()
					local c_z = coora.z -1
					for(local j = c_z;j<=(c_z+2);j++){
						local c_test = square_x(coora.x,coora.y).get_tile_at_height(j)
						local is_tile = true
						try {
							 c_test.is_valid()
						}
						catch(ev) {
							is_tile = false
							//gui.add_message("This faill")
						}
						if(is_tile && c_test.is_valid()){
							local t = tile_x(coora.x, coora.y, coora.z)
							local way = c_test.find_object(mo_way)
							if(t.is_bridge())c_test.z = coora.z

							//gui.add_message(""+coora.y+","+c_test.z+"  - "+way+"")
							if(way){
								coora.z = c_test.z
								break
							}
						}
					}
					
					if(coora.x==coorb.x && coora.y==coorb.y && coora.z==coorb.z){
						return {c = coora, result = true}
					}
					if ((dir==1)||(dir==2)||(dir==4)||(dir==8)){
						way.mark()
						tile.mark()
						return {c = coora, result = false}					
					}
					else if(dir_start == 1){ //y--
						switch (dir) {
							case 5:
								coora.y--
								dir_start = 1
							break
							case 6:
								coora.x++
								dir_start = 2
							break
							case 12:
								coora.x--
								dir_start = 8
							break
							default:
								coora.y--
							break
						}
					}
					else if(dir_start == 2){ //x++
						switch (dir) {
							case 9:
								coora.y--
								dir_start = 1
							break
							case 12: 
								coora.y++
								dir_start = 4
							break
							default:
								coora.x++
							break
						}
					}
					else if(dir_start == 4){ //y++
						switch (dir) {
							case 3:
								coora.x++	
								dir_start = 2
							break
							case 12:
								coora.x--
								dir_start = 8
							break
							case 9:
								coora.x--
								dir_start = 8
							break
							default:
								coora.y++
							break
						}
					}
					else if(dir_start == 8){ //x--
						switch (dir) {
							case 3:
								coora.y--	
								dir_start = 1					
							break
							case 6:
								coora.y++
								dir_start = 4
							break
							case 12:
								coora.y--
								dir_start = 12
							break
							default:
								coora.x--
							break
						}
					}
				}
				else return {c = coora, result = false}
			}
		}
		else return {c = coora, result = false}
	}
}        // END of class

// END OF FILE
