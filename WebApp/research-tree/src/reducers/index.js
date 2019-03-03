import { combineReducers } from 'redux';
import AccountReducer from './AccountReducer';
import FeedReducer from './FeedReducer';

export default combineReducers({
    user: AccountReducer,
    feed: FeedReducer
});