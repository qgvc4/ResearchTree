import { combineReducers } from 'redux';
import AccountReducer from './AccountReducer';
import FeedReducer from './FeedReducer';
import JobReducer from './JobReducer';

export default combineReducers({
    user: AccountReducer,
    feed: FeedReducer,
    job: JobReducer
});