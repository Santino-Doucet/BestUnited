import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
eagerLoadControllersFrom("controllers", application);

import SwiperController from "../controllers/swiper_controller";
application.register("swiper", SwiperController);

import TabsController from "../controllers/tabs_controller";
application.register("tabs", TabsController);

import ReadMoreController from "./read_more_controller";
application.register("read-more", ReadMoreController);

import OrderDetailsController from "./order_details_controller";
application.register("order-details", OrderDetailsController);
